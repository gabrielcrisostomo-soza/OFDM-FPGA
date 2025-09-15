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
static const char *ng0 = "D:/Desktop/tcc/ofdm_64qam_n8_w16_cp2/source_gen1.v";
static unsigned int ng1[] = {44257U, 0U};
static unsigned int ng2[] = {3735928559U, 0U};
static unsigned int ng3[] = {0U, 0U};
static int ng4[] = {0, 0};
static int ng5[] = {1, 0};



static void Always_37_0(char *t0)
{
    char t13[8];
    char t14[8];
    char t25[8];
    char t34[8];
    char t51[8];
    char t60[8];
    char t77[8];
    char t86[8];
    char t100[8];
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
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t26;
    char *t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    char *t38;
    char *t39;
    char *t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    char *t48;
    char *t49;
    char *t50;
    char *t52;
    char *t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    char *t64;
    char *t65;
    char *t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    char *t74;
    char *t75;
    char *t76;
    char *t78;
    char *t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    char *t90;
    char *t91;
    char *t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned int t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    char *t101;
    char *t102;
    char *t103;
    char *t104;
    char *t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    char *t112;

LAB0:    t1 = (t0 + 3328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(37, ng0);
    t2 = (t0 + 3648);
    *((int *)t2) = 1;
    t3 = (t0 + 3360);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(37, ng0);

LAB5:    xsi_set_current_line(38, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(55, ng0);

LAB40:    xsi_set_current_line(56, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);

LAB12:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(38, ng0);

LAB9:    xsi_set_current_line(39, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 16, 0LL);
    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 32, 0LL);
    xsi_set_current_line(41, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 8, 0LL);
    xsi_set_current_line(43, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB8;

LAB10:    xsi_set_current_line(44, ng0);

LAB13:    xsi_set_current_line(45, ng0);
    t4 = (t0 + 2248);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    memset(t14, 0, 8);
    t12 = (t14 + 4);
    t15 = (t11 + 4);
    t16 = *((unsigned int *)t11);
    t17 = (t16 >> 15);
    t18 = (t17 & 1);
    *((unsigned int *)t14) = t18;
    t19 = *((unsigned int *)t15);
    t20 = (t19 >> 15);
    t21 = (t20 & 1);
    *((unsigned int *)t12) = t21;
    t22 = (t0 + 2248);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memset(t25, 0, 8);
    t26 = (t25 + 4);
    t27 = (t24 + 4);
    t28 = *((unsigned int *)t24);
    t29 = (t28 >> 13);
    t30 = (t29 & 1);
    *((unsigned int *)t25) = t30;
    t31 = *((unsigned int *)t27);
    t32 = (t31 >> 13);
    t33 = (t32 & 1);
    *((unsigned int *)t26) = t33;
    t35 = *((unsigned int *)t14);
    t36 = *((unsigned int *)t25);
    t37 = (t35 ^ t36);
    *((unsigned int *)t34) = t37;
    t38 = (t14 + 4);
    t39 = (t25 + 4);
    t40 = (t34 + 4);
    t41 = *((unsigned int *)t38);
    t42 = *((unsigned int *)t39);
    t43 = (t41 | t42);
    *((unsigned int *)t40) = t43;
    t44 = *((unsigned int *)t40);
    t45 = (t44 != 0);
    if (t45 == 1)
        goto LAB14;

LAB15:
LAB16:    t48 = (t0 + 2248);
    t49 = (t48 + 56U);
    t50 = *((char **)t49);
    memset(t51, 0, 8);
    t52 = (t51 + 4);
    t53 = (t50 + 4);
    t54 = *((unsigned int *)t50);
    t55 = (t54 >> 12);
    t56 = (t55 & 1);
    *((unsigned int *)t51) = t56;
    t57 = *((unsigned int *)t53);
    t58 = (t57 >> 12);
    t59 = (t58 & 1);
    *((unsigned int *)t52) = t59;
    t61 = *((unsigned int *)t34);
    t62 = *((unsigned int *)t51);
    t63 = (t61 ^ t62);
    *((unsigned int *)t60) = t63;
    t64 = (t34 + 4);
    t65 = (t51 + 4);
    t66 = (t60 + 4);
    t67 = *((unsigned int *)t64);
    t68 = *((unsigned int *)t65);
    t69 = (t67 | t68);
    *((unsigned int *)t66) = t69;
    t70 = *((unsigned int *)t66);
    t71 = (t70 != 0);
    if (t71 == 1)
        goto LAB17;

LAB18:
LAB19:    t74 = (t0 + 2248);
    t75 = (t74 + 56U);
    t76 = *((char **)t75);
    memset(t77, 0, 8);
    t78 = (t77 + 4);
    t79 = (t76 + 4);
    t80 = *((unsigned int *)t76);
    t81 = (t80 >> 10);
    t82 = (t81 & 1);
    *((unsigned int *)t77) = t82;
    t83 = *((unsigned int *)t79);
    t84 = (t83 >> 10);
    t85 = (t84 & 1);
    *((unsigned int *)t78) = t85;
    t87 = *((unsigned int *)t60);
    t88 = *((unsigned int *)t77);
    t89 = (t87 ^ t88);
    *((unsigned int *)t86) = t89;
    t90 = (t60 + 4);
    t91 = (t77 + 4);
    t92 = (t86 + 4);
    t93 = *((unsigned int *)t90);
    t94 = *((unsigned int *)t91);
    t95 = (t93 | t94);
    *((unsigned int *)t92) = t95;
    t96 = *((unsigned int *)t92);
    t97 = (t96 != 0);
    if (t97 == 1)
        goto LAB20;

LAB21:
LAB22:    t101 = (t0 + 2248);
    t102 = (t101 + 56U);
    t103 = *((char **)t102);
    memset(t100, 0, 8);
    t104 = (t100 + 4);
    t105 = (t103 + 4);
    t106 = *((unsigned int *)t103);
    t107 = (t106 >> 0);
    *((unsigned int *)t100) = t107;
    t108 = *((unsigned int *)t105);
    t109 = (t108 >> 0);
    *((unsigned int *)t104) = t109;
    t110 = *((unsigned int *)t100);
    *((unsigned int *)t100) = (t110 & 32767U);
    t111 = *((unsigned int *)t104);
    *((unsigned int *)t104) = (t111 & 32767U);
    xsi_vlogtype_concat(t13, 16, 16, 2U, t100, 15, t86, 1);
    t112 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t112, t13, 0, 0, 16, 0LL);
    xsi_set_current_line(46, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t14, 0, 8);
    t5 = (t14 + 4);
    t11 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 31);
    t8 = (t7 & 1);
    *((unsigned int *)t14) = t8;
    t9 = *((unsigned int *)t11);
    t10 = (t9 >> 31);
    t16 = (t10 & 1);
    *((unsigned int *)t5) = t16;
    t12 = (t0 + 2408);
    t15 = (t12 + 56U);
    t22 = *((char **)t15);
    memset(t25, 0, 8);
    t23 = (t25 + 4);
    t24 = (t22 + 4);
    t17 = *((unsigned int *)t22);
    t18 = (t17 >> 21);
    t19 = (t18 & 1);
    *((unsigned int *)t25) = t19;
    t20 = *((unsigned int *)t24);
    t21 = (t20 >> 21);
    t28 = (t21 & 1);
    *((unsigned int *)t23) = t28;
    t29 = *((unsigned int *)t14);
    t30 = *((unsigned int *)t25);
    t31 = (t29 ^ t30);
    *((unsigned int *)t34) = t31;
    t26 = (t14 + 4);
    t27 = (t25 + 4);
    t38 = (t34 + 4);
    t32 = *((unsigned int *)t26);
    t33 = *((unsigned int *)t27);
    t35 = (t32 | t33);
    *((unsigned int *)t38) = t35;
    t36 = *((unsigned int *)t38);
    t37 = (t36 != 0);
    if (t37 == 1)
        goto LAB23;

LAB24:
LAB25:    t39 = (t0 + 2408);
    t40 = (t39 + 56U);
    t48 = *((char **)t40);
    memset(t51, 0, 8);
    t49 = (t51 + 4);
    t50 = (t48 + 4);
    t43 = *((unsigned int *)t48);
    t44 = (t43 >> 1);
    t45 = (t44 & 1);
    *((unsigned int *)t51) = t45;
    t46 = *((unsigned int *)t50);
    t47 = (t46 >> 1);
    t54 = (t47 & 1);
    *((unsigned int *)t49) = t54;
    t55 = *((unsigned int *)t34);
    t56 = *((unsigned int *)t51);
    t57 = (t55 ^ t56);
    *((unsigned int *)t60) = t57;
    t52 = (t34 + 4);
    t53 = (t51 + 4);
    t64 = (t60 + 4);
    t58 = *((unsigned int *)t52);
    t59 = *((unsigned int *)t53);
    t61 = (t58 | t59);
    *((unsigned int *)t64) = t61;
    t62 = *((unsigned int *)t64);
    t63 = (t62 != 0);
    if (t63 == 1)
        goto LAB26;

LAB27:
LAB28:    t65 = (t0 + 2408);
    t66 = (t65 + 56U);
    t74 = *((char **)t66);
    memset(t77, 0, 8);
    t75 = (t77 + 4);
    t76 = (t74 + 4);
    t69 = *((unsigned int *)t74);
    t70 = (t69 >> 0);
    t71 = (t70 & 1);
    *((unsigned int *)t77) = t71;
    t72 = *((unsigned int *)t76);
    t73 = (t72 >> 0);
    t80 = (t73 & 1);
    *((unsigned int *)t75) = t80;
    t81 = *((unsigned int *)t60);
    t82 = *((unsigned int *)t77);
    t83 = (t81 ^ t82);
    *((unsigned int *)t86) = t83;
    t78 = (t60 + 4);
    t79 = (t77 + 4);
    t90 = (t86 + 4);
    t84 = *((unsigned int *)t78);
    t85 = *((unsigned int *)t79);
    t87 = (t84 | t85);
    *((unsigned int *)t90) = t87;
    t88 = *((unsigned int *)t90);
    t89 = (t88 != 0);
    if (t89 == 1)
        goto LAB29;

LAB30:
LAB31:    t91 = (t0 + 2408);
    t92 = (t91 + 56U);
    t101 = *((char **)t92);
    memset(t100, 0, 8);
    t102 = (t100 + 4);
    t103 = (t101 + 4);
    t95 = *((unsigned int *)t101);
    t96 = (t95 >> 0);
    *((unsigned int *)t100) = t96;
    t97 = *((unsigned int *)t103);
    t98 = (t97 >> 0);
    *((unsigned int *)t102) = t98;
    t99 = *((unsigned int *)t100);
    *((unsigned int *)t100) = (t99 & 2147483647U);
    t106 = *((unsigned int *)t102);
    *((unsigned int *)t102) = (t106 & 2147483647U);
    xsi_vlogtype_concat(t13, 32, 32, 2U, t100, 31, t86, 1);
    t104 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t104, t13, 0, 0, 32, 0LL);
    xsi_set_current_line(47, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t3 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t3);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB32;

LAB33:    xsi_set_current_line(49, ng0);

LAB36:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t13, 0, 8);
    t5 = (t13 + 4);
    t11 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 0);
    *((unsigned int *)t13) = t7;
    t8 = *((unsigned int *)t11);
    t9 = (t8 >> 0);
    *((unsigned int *)t5) = t9;
    t10 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t10 & 255U);
    t16 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t16 & 255U);
    t12 = (t0 + 2408);
    t15 = (t12 + 56U);
    t22 = *((char **)t15);
    memset(t14, 0, 8);
    t23 = (t14 + 4);
    t24 = (t22 + 4);
    t17 = *((unsigned int *)t22);
    t18 = (t17 >> 8);
    *((unsigned int *)t14) = t18;
    t19 = *((unsigned int *)t24);
    t20 = (t19 >> 8);
    *((unsigned int *)t23) = t20;
    t21 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t21 & 255U);
    t28 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t28 & 255U);
    t29 = *((unsigned int *)t13);
    t30 = *((unsigned int *)t14);
    t31 = (t29 ^ t30);
    *((unsigned int *)t25) = t31;
    t26 = (t13 + 4);
    t27 = (t14 + 4);
    t38 = (t25 + 4);
    t32 = *((unsigned int *)t26);
    t33 = *((unsigned int *)t27);
    t35 = (t32 | t33);
    *((unsigned int *)t38) = t35;
    t36 = *((unsigned int *)t38);
    t37 = (t36 != 0);
    if (t37 == 1)
        goto LAB37;

LAB38:
LAB39:    t39 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t39, t25, 0, 0, 8, 0LL);

LAB34:    xsi_set_current_line(54, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB12;

LAB14:    t46 = *((unsigned int *)t34);
    t47 = *((unsigned int *)t40);
    *((unsigned int *)t34) = (t46 | t47);
    goto LAB16;

LAB17:    t72 = *((unsigned int *)t60);
    t73 = *((unsigned int *)t66);
    *((unsigned int *)t60) = (t72 | t73);
    goto LAB19;

LAB20:    t98 = *((unsigned int *)t86);
    t99 = *((unsigned int *)t92);
    *((unsigned int *)t86) = (t98 | t99);
    goto LAB22;

LAB23:    t41 = *((unsigned int *)t34);
    t42 = *((unsigned int *)t38);
    *((unsigned int *)t34) = (t41 | t42);
    goto LAB25;

LAB26:    t67 = *((unsigned int *)t60);
    t68 = *((unsigned int *)t64);
    *((unsigned int *)t60) = (t67 | t68);
    goto LAB28;

LAB29:    t93 = *((unsigned int *)t86);
    t94 = *((unsigned int *)t90);
    *((unsigned int *)t86) = (t93 | t94);
    goto LAB31;

LAB32:    xsi_set_current_line(47, ng0);

LAB35:    xsi_set_current_line(48, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 8, 0LL);
    goto LAB34;

LAB37:    t41 = *((unsigned int *)t25);
    t42 = *((unsigned int *)t38);
    *((unsigned int *)t25) = (t41 | t42);
    goto LAB39;

}


extern void work_m_00000000002134941083_0707128533_init()
{
	static char *pe[] = {(void *)Always_37_0};
	xsi_register_didat("work_m_00000000002134941083_0707128533", "isim/top_module_tb_isim_beh.exe.sim/work/m_00000000002134941083_0707128533.didat");
	xsi_register_executes(pe);
}
