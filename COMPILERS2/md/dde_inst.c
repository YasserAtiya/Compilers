/*
   dde_inst.c
*/
//USE HEADER INSTEAD IN INST.C
#include "dde_inst.h"
#include "stdio.h"

void print_dde_inst(char* inst_op, int left_signal, int left_base, int left_disp, int pred_base, int pred_displace,
                                   int right_signal, int right_base, int right_disp, int right_pred)
{
   print_dde_first_inst(left_signal,  left_base,  left_disp,  pred_base, pred_displace);
   print_dde_second_inst(inst_op, right_signal,  right_base,  right_disp,  right_pred);
}
void print_dde_first_inst(int left_signal, int left_base, int left_disp, int pred_base, int pred_displace)
{
   printf("\tdde\t%d,s[%d],%d,%d,%d\n",left_signal, left_base, left_disp, pred_base, pred_displace);
}
void print_dde_second_inst(char* inst_op, int right_signal, int right_base, int right_disp, int right_pred)
{
   printf("\t%s\t%d,s[%d],%d,%d,%d\n",inst_op, right_signal, right_base, right_disp, right_pred);
}
