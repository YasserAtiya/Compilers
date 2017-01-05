/*
   dde_inst.h
*/

#ifndef DDE_INST_H
#define DDE_INST_H


void print_dde_inst(char* inst_op, int left_signal, int left_base, int left_disp, int pred_base, int pred_displace,
                                   int right_signal, int right_base, int right_disp, int right_pred);
void print_dde_first_inst(int left_signal, int left_base, int left_disp, int pred_base, int pred_displace);
void print_dde_second_inst(char* inst_op, int right_signal, int right_base, int right_disp, int right_pred);


#endif
