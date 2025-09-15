/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/Desktop/tcc/ofdm_16-qam_n32_w64_cp16/spi_16.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static unsigned int ng3[] = {0U, 0U};
static int ng4[] = {2, 0};
static int ng5[] = {16, 0};



static void Always_41_0(char *t0)
{
    char t14[8];
    char t22[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    int t13;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;

LAB0:    t1 = (t0 + 3648U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 3968);
    *((int *)t2) = 1;
    t3 = (t0 + 3680);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(41, ng0);

LAB5:    xsi_set_current_line(42, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(49, ng0);

LAB10:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2568);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB11:    t5 = ((char*)((ng1)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 8, t5, 32);
    if (t13 == 1)
        goto LAB12;

LAB13:    t2 = ((char*)((ng2)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 8, t2, 32);
    if (t13 == 1)
        goto LAB14;

LAB15:    t2 = ((char*)((ng4)));
    t13 = xsi_vlog_unsigned_case_compare(t4, 8, t2, 32);
    if (t13 == 1)
        goto LAB16;

LAB17:
LAB19:
LAB18:    xsi_set_current_line(77, ng0);

LAB42:    xsi_set_current_line(78, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 8, 0LL);

LAB20:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(42, ng0);

LAB9:    xsi_set_current_line(43, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 8, 0LL);
    xsi_set_current_line(44, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(45, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(46, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 6, 0LL);
    xsi_set_current_line(47, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 16, 0LL);
    goto LAB8;

LAB12:    xsi_set_current_line(51, ng0);

LAB21:    xsi_set_current_line(52, ng0);
    t11 = ((char*)((ng2)));
    t12 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 1, 0LL);
    xsi_set_current_line(54, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB22;

LAB23:
LAB24:    goto LAB20;

LAB14:    xsi_set_current_line(58, ng0);

LAB26:    xsi_set_current_line(59, ng0);
    t3 = ((char*)((ng1)));
    t5 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t5, t3, 0, 0, 1, 0LL);
    xsi_set_current_line(60, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t2, t3, 0, 0, 16, 0LL);
    xsi_set_current_line(61, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 6, 0LL);
    xsi_set_current_line(62, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 8, 0LL);
    goto LAB20;

LAB16:    xsi_set_current_line(64, ng0);

LAB27:    xsi_set_current_line(65, ng0);
    t3 = (t0 + 2408);
    t5 = (t3 + 56U);
    t11 = *((char **)t5);
    t12 = ((char*)((ng5)));
    memset(t14, 0, 8);
    t15 = (t11 + 4);
    if (*((unsigned int *)t15) != 0)
        goto LAB29;

LAB28:    t16 = (t12 + 4);
    if (*((unsigned int *)t16) != 0)
        goto LAB29;

LAB32:    if (*((unsigned int *)t11) < *((unsigned int *)t12))
        goto LAB30;

LAB31:    t18 = (t14 + 4);
    t6 = *((unsigned int *)t18);
    t7 = (~(t6));
    t8 = *((unsigned int *)t14);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB33;

LAB34:    xsi_set_current_line(69, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB37;

LAB38:    xsi_set_current_line(72, ng0);

LAB41:    xsi_set_current_line(73, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(74, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 8, 0LL);

LAB39:
LAB35:    goto LAB20;

LAB22:    xsi_set_current_line(54, ng0);

LAB25:    xsi_set_current_line(55, ng0);
    t5 = ((char*)((ng2)));
    t11 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t11, t5, 0, 0, 8, 0LL);
    goto LAB24;

LAB29:    t17 = (t14 + 4);
    *((unsigned int *)t14) = 1;
    *((unsigned int *)t17) = 1;
    goto LAB31;

LAB30:    *((unsigned int *)t14) = 1;
    goto LAB31;

LAB33:    xsi_set_current_line(65, ng0);

LAB36:    xsi_set_current_line(66, ng0);
    t19 = (t0 + 2248);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memset(t22, 0, 8);
    t23 = (t22 + 4);
    t24 = (t21 + 4);
    t25 = *((unsigned int *)t21);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t22) = t27;
    t28 = *((unsigned int *)t24);
    t29 = (t28 >> 15);
    t30 = (t29 & 1);
    *((unsigned int *)t23) = t30;
    t31 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t31, t22, 0, 0, 1, 0LL);
    xsi_set_current_line(67, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 2248);
    t5 = (t3 + 56U);
    t11 = *((char **)t5);
    memset(t22, 0, 8);
    t12 = (t22 + 4);
    t15 = (t11 + 4);
    t6 = *((unsigned int *)t11);
    t7 = (t6 >> 0);
    *((unsigned int *)t22) = t7;
    t8 = *((unsigned int *)t15);
    t9 = (t8 >> 0);
    *((unsigned int *)t12) = t9;
    t10 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t10 & 32767U);
    t25 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t25 & 32767U);
    xsi_vlogtype_concat(t14, 16, 16, 2U, t22, 15, t2, 1);
    t16 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t16, t14, 0, 0, 16, 0LL);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t11 = ((char*)((ng2)));
    memset(t14, 0, 8);
    xsi_vlog_unsigned_add(t14, 32, t5, 6, t11, 32);
    t12 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t12, t14, 0, 0, 6, 0LL);
    goto LAB35;

LAB37:    xsi_set_current_line(69, ng0);

LAB40:    xsi_set_current_line(70, ng0);
    t5 = ((char*)((ng2)));
    t11 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t11, t5, 0, 0, 1, 0LL);
    xsi_set_current_line(71, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2568);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 8, 0LL);
    goto LAB39;

}


extern void work_m_00000000002275294563_2316582802_init()
{
	static char *pe[] = {(void *)Always_41_0};
	xsi_register_didat("work_m_00000000002275294563_2316582802", "isim/top_module_tb_isim_beh.exe.sim/work/m_00000000002275294563_2316582802.didat");
	xsi_register_executes(pe);
}
