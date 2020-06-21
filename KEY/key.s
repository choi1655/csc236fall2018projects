	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	leaq	L_.str(%rip), %rdi
	movl	$0, -4(%rbp)
	callq	_system
	leaq	L_.str.1(%rip), %rdi
	leaq	-5(%rbp), %rsi
	movl	%eax, -12(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_scanf
	movl	%eax, -16(%rbp)         ## 4-byte Spill
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movsbl	-5(%rbp), %eax
	cmpl	$46, %eax
	je	LBB0_11
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movsbl	-5(%rbp), %eax
	cmpl	$97, %eax
	jl	LBB0_5
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movsbl	-5(%rbp), %eax
	cmpl	$122, %eax
	jg	LBB0_5
## %bb.4:                               ##   in Loop: Header=BB0_1 Depth=1
	movsbl	-5(%rbp), %eax
	subl	$32, %eax
	movb	%al, %cl
	movb	%cl, -5(%rbp)
LBB0_5:                                 ##   in Loop: Header=BB0_1 Depth=1
	movsbl	-5(%rbp), %eax
	cmpl	$65, %eax
	jl	LBB0_7
## %bb.6:                               ##   in Loop: Header=BB0_1 Depth=1
	movsbl	-5(%rbp), %eax
	cmpl	$90, %eax
	jle	LBB0_8
LBB0_7:                                 ##   in Loop: Header=BB0_1 Depth=1
	movsbl	-5(%rbp), %eax
	cmpl	$32, %eax
	jne	LBB0_9
LBB0_8:                                 ##   in Loop: Header=BB0_1 Depth=1
	leaq	L_.str.1(%rip), %rdi
	movsbl	-5(%rbp), %esi
	movb	$0, %al
	callq	_printf
	leaq	L_.str.1(%rip), %rdi
	leaq	-5(%rbp), %rsi
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_scanf
	movl	%eax, -24(%rbp)         ## 4-byte Spill
	jmp	LBB0_10
LBB0_9:                                 ##   in Loop: Header=BB0_1 Depth=1
	leaq	L_.str.1(%rip), %rdi
	leaq	-5(%rbp), %rsi
	movb	$0, %al
	callq	_scanf
	movl	%eax, -28(%rbp)         ## 4-byte Spill
	jmp	LBB0_1
LBB0_10:                                ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_1
LBB0_11:
	leaq	L_.str.2(%rip), %rdi
	callq	_system
	leaq	L_.str.3(%rip), %rdi
	movsbl	-5(%rbp), %esi
	movl	%eax, -32(%rbp)         ## 4-byte Spill
	movb	$0, %al
	callq	_printf
	xorl	%esi, %esi
	movl	%eax, -36(%rbp)         ## 4-byte Spill
	movl	%esi, %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"/bin/stty raw"

L_.str.1:                               ## @.str.1
	.asciz	"%c"

L_.str.2:                               ## @.str.2
	.asciz	"/bin/stty cooked"

L_.str.3:                               ## @.str.3
	.asciz	"%c\n"


.subsections_via_symbols
