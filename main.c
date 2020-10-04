#include <stdio.h>
#include <stdint.h>
#include <xtime_l.h>
#include "platform.h"
#include "xil_printf.h"

#define SIGN_MASK 0x80

//weight : (1,0,7)
//image, activations : (1,5,2)
//multiplication & accumulation tmp result : (1,8,7)
//all weight, image, activations, result use 2's complement

int main() {

	init_platform();

	uint8_t input_image[7056] = {
#include "image_84_84_x10"
	};
	uint8_t conv_weight[9] = {
#include "conv_weight"
	};

	uint8_t conv_activation[6724] = {
#include "conv_activation_fixed"
	};

	uint8_t max_pooling_activation[1681] = {
#include "max_pooling_activation_fixed"
	};

	uint32_t *start_sig = (uint32_t *) 0x50000000;
	uint32_t *end_sig = (uint32_t *) 0x50000004;

	uint8_t *input_image_fpga = (uint8_t *) 0x40000000;
	uint8_t *conv_weight_fpga = (uint8_t *) 0x40010000;
	uint8_t *activation_fpga = (uint8_t *) 0x40020000;

	XTime start, end;

	print("\n@@@@@@ Accel Start @@@@@@\n");
	//Calculation Start
	XTime_GetTime(&start);

	memcpy(input_image_fpga, input_image, 7056*sizeof(uint8_t));
	memcpy(conv_weight_fpga, conv_weight, 9*sizeof(uint8_t));

	start_sig[0] = 0x01020304;

	//Wait for Finishing Sig
	while(1) {
		if (end_sig[0] == 0x04030201)
			break;
	}

	//Calculation End
	XTime_GetTime(&end);
	print("@@@@@@ Accel Finish @@@@@@\n\n");

	int i;
	//Correctness Check
	for (i=0; i<1681; i++)
	{
		uint8_t act = max_pooling_activation[i];
		uint8_t lower_bound;
		uint8_t upper_bound = act +1;
		if ( act == 0 )
			lower_bound = act;
		else
			lower_bound = act -1;

		if ( activation_fpga[i] & 0x80 != 0 )
			break;
		if ( activation_fpga[i] < lower_bound )
			break;
		if ( upper_bound < activation_fpga[i] )
			break;
	}

	if ( i == SIZE ) {
		print("@@@@@@ CORRECT @@@@@@\n");

		printf("FPGA:\t%.3lf ms\n", (double)(end-start)/(COUNTS_PER_SECOND/1000));
	}
	else {
		print("@@@@@@ FAIL @@@@@@");

		printf("Index %d : Activation should be %x, but %x is calculated\n", i, max_pooling_activation[i], activation_fpga[i]);
	}


	cleanup_platform();
	return 0;
}
