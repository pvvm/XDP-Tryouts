; ModuleID = 'kernel_xdp.c'
source_filename = "kernel_xdp.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.inner_app_array = type { ptr, ptr, ptr, ptr }
%struct.anon = type { ptr, ptr, ptr, ptr }
%struct.anon.0 = type { ptr, ptr, ptr, ptr }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, %union.anon }
%union.anon = type { %struct.anon.1 }
%struct.anon.1 = type { i32, i32 }
%struct.tcphdr = type { i16, i16, i32, i32, i16, i16, i16, i16 }
%struct.timer_event = type <{ i32, i32, %struct.bpf_timer }>
%struct.bpf_timer = type { i128 }

@inner_app_array0 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !0
@inner_app_array1 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !164
@inner_app_array2 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !166
@inner_app_array3 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !168
@inner_app_array4 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !170
@inner_app_array5 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !172
@inner_app_array6 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !174
@inner_app_array7 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !176
@inner_app_array8 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !178
@inner_app_array9 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !180
@inner_app_array10 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !182
@inner_app_array11 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !184
@inner_app_array12 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !186
@inner_app_array13 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !188
@inner_app_array14 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !190
@inner_app_array15 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !192
@inner_app_array16 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !194
@inner_app_array17 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !196
@inner_app_array18 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !198
@inner_app_array19 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !200
@outer_app_hash = dso_local global { ptr, ptr, ptr, [20 x ptr] } { ptr null, ptr null, ptr null, [20 x ptr] [ptr @inner_app_array0, ptr @inner_app_array1, ptr @inner_app_array2, ptr @inner_app_array3, ptr @inner_app_array4, ptr @inner_app_array5, ptr @inner_app_array6, ptr @inner_app_array7, ptr @inner_app_array8, ptr @inner_app_array9, ptr @inner_app_array10, ptr @inner_app_array11, ptr @inner_app_array12, ptr @inner_app_array13, ptr @inner_app_array14, ptr @inner_app_array15, ptr @inner_app_array16, ptr @inner_app_array17, ptr @inner_app_array18, ptr @inner_app_array19] }, section ".maps", align 8, !dbg !52
@rx_module.____fmt = internal constant [6 x i8] c"%d %d\00", align 1, !dbg !107
@rx_module.____fmt.1 = internal constant [6 x i8] c"%d %d\00", align 1, !dbg !136
@xsks_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !148
@rx_module.____fmt.2 = internal constant [11 x i8] c"TEST %d %d\00", align 1, !dbg !138
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !143
@timer_array = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !202
@initialize_timer.____fmt = internal constant [30 x i8] c"Couldn't get entry of the map\00", align 1, !dbg !230
@initialize_timer.____fmt.3 = internal constant [36 x i8] c"Error while initializing timer: %ld\00", align 1, !dbg !242
@initialize_timer.____fmt.4 = internal constant [34 x i8] c"Error while setting callback: %ld\00", align 1, !dbg !247
@timer_triggered.____fmt = internal constant [8 x i8] c"CPU: %d\00", align 1, !dbg !263
@llvm.compiler.used = appending global [25 x ptr] [ptr @_license, ptr @inner_app_array0, ptr @inner_app_array1, ptr @inner_app_array10, ptr @inner_app_array11, ptr @inner_app_array12, ptr @inner_app_array13, ptr @inner_app_array14, ptr @inner_app_array15, ptr @inner_app_array16, ptr @inner_app_array17, ptr @inner_app_array18, ptr @inner_app_array19, ptr @inner_app_array2, ptr @inner_app_array3, ptr @inner_app_array4, ptr @inner_app_array5, ptr @inner_app_array6, ptr @inner_app_array7, ptr @inner_app_array8, ptr @inner_app_array9, ptr @outer_app_hash, ptr @rx_module, ptr @timer_array, ptr @xsks_map], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @rx_module(ptr nocapture noundef readonly %0) #0 section "xdp" !dbg !109 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata ptr undef, metadata !124, metadata !DIExpression(DW_OP_LLVM_fragment, 32, 96)), !dbg !295
  call void @llvm.dbg.value(metadata ptr %0, metadata !122, metadata !DIExpression()), !dbg !296
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3) #5, !dbg !297
  %4 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 4, !dbg !298
  %5 = load i32, ptr %4, align 4, !dbg !298, !tbaa !299
  call void @llvm.dbg.value(metadata i32 %5, metadata !123, metadata !DIExpression()), !dbg !296
  store i32 %5, ptr %3, align 4, !dbg !304, !tbaa !305
  call void @llvm.dbg.value(metadata ptr %0, metadata !306, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata ptr undef, metadata !312, metadata !DIExpression()), !dbg !392
  %6 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !395
  %7 = load i32, ptr %6, align 4, !dbg !395, !tbaa !396
  %8 = zext i32 %7 to i64, !dbg !397
  %9 = inttoptr i64 %8 to ptr, !dbg !398
  call void @llvm.dbg.value(metadata ptr %9, metadata !313, metadata !DIExpression()), !dbg !392
  %10 = load i32, ptr %0, align 4, !dbg !399, !tbaa !400
  %11 = zext i32 %10 to i64, !dbg !401
  %12 = inttoptr i64 %11 to ptr, !dbg !402
  call void @llvm.dbg.value(metadata ptr %12, metadata !314, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata ptr %12, metadata !377, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata ptr undef, metadata !403, metadata !DIExpression()), !dbg !412
  call void @llvm.dbg.value(metadata ptr %9, metadata !410, metadata !DIExpression()), !dbg !412
  call void @llvm.dbg.value(metadata ptr undef, metadata !411, metadata !DIExpression()), !dbg !412
  call void @llvm.dbg.value(metadata ptr undef, metadata !414, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata ptr %9, metadata !424, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata ptr undef, metadata !425, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata ptr null, metadata !426, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata ptr %12, metadata !427, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata i32 14, metadata !428, metadata !DIExpression()), !dbg !437
  %13 = getelementptr i8, ptr %12, i64 14, !dbg !439
  %14 = icmp ugt ptr %13, %9, !dbg !441
  br i1 %14, label %133, label %15, !dbg !442

15:                                               ; preds = %1
  call void @llvm.dbg.value(metadata ptr %13, metadata !377, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata ptr %13, metadata !429, metadata !DIExpression()), !dbg !437
  %16 = getelementptr inbounds %struct.ethhdr, ptr %12, i64 0, i32 2, !dbg !443
  call void @llvm.dbg.value(metadata i16 poison, metadata !435, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata i32 0, metadata !436, metadata !DIExpression()), !dbg !437
  %17 = load i16, ptr %16, align 1, !dbg !437, !tbaa !444
  call void @llvm.dbg.value(metadata i16 %17, metadata !435, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata i16 %17, metadata !446, metadata !DIExpression()), !dbg !451
  %18 = icmp eq i16 %17, 129, !dbg !457
  %19 = icmp eq i16 %17, -22392, !dbg !458
  %20 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %18)
  %21 = or i1 %19, %20, !dbg !458
  %22 = getelementptr i8, ptr %12, i64 18
  %23 = icmp ule ptr %22, %9
  %24 = select i1 %21, i1 %23, i1 false, !dbg !459
  br i1 %24, label %25, label %38, !dbg !459

25:                                               ; preds = %15
  call void @llvm.dbg.value(metadata i16 poison, metadata !435, metadata !DIExpression()), !dbg !437
  %26 = getelementptr i8, ptr %12, i64 16, !dbg !460
  call void @llvm.dbg.value(metadata ptr %22, metadata !429, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata i32 1, metadata !436, metadata !DIExpression()), !dbg !437
  %27 = load i16, ptr %26, align 1, !dbg !437, !tbaa !444
  call void @llvm.dbg.value(metadata i16 %27, metadata !435, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata i16 %27, metadata !446, metadata !DIExpression()), !dbg !451
  %28 = icmp eq i16 %27, 129, !dbg !457
  %29 = icmp eq i16 %27, -22392, !dbg !458
  %30 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %28)
  %31 = or i1 %29, %30, !dbg !458
  %32 = getelementptr i8, ptr %12, i64 22
  %33 = icmp ule ptr %32, %9
  %34 = select i1 %31, i1 %33, i1 false, !dbg !459
  br i1 %34, label %35, label %38, !dbg !459

35:                                               ; preds = %25
  call void @llvm.dbg.value(metadata i16 poison, metadata !435, metadata !DIExpression()), !dbg !437
  %36 = getelementptr i8, ptr %12, i64 20, !dbg !460
  call void @llvm.dbg.value(metadata ptr %32, metadata !429, metadata !DIExpression()), !dbg !437
  call void @llvm.dbg.value(metadata i32 2, metadata !436, metadata !DIExpression()), !dbg !437
  %37 = load i16, ptr %36, align 1, !dbg !437, !tbaa !444
  call void @llvm.dbg.value(metadata i16 %37, metadata !435, metadata !DIExpression()), !dbg !437
  br label %38

38:                                               ; preds = %35, %25, %15
  %39 = phi ptr [ %13, %15 ], [ %22, %25 ], [ %32, %35 ], !dbg !437
  %40 = phi i16 [ %17, %15 ], [ %27, %25 ], [ %37, %35 ], !dbg !437
  call void @llvm.dbg.value(metadata ptr %39, metadata !377, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata i16 %40, metadata !382, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %41 = icmp ne i16 %40, 8, !dbg !461
  %42 = getelementptr inbounds %struct.iphdr, ptr %39, i64 1
  %43 = icmp ugt ptr %42, %9
  %44 = select i1 %41, i1 true, i1 %43, !dbg !463
  call void @llvm.dbg.value(metadata ptr undef, metadata !464, metadata !DIExpression()), !dbg !474
  call void @llvm.dbg.value(metadata ptr %9, metadata !470, metadata !DIExpression()), !dbg !474
  call void @llvm.dbg.value(metadata ptr undef, metadata !471, metadata !DIExpression()), !dbg !474
  call void @llvm.dbg.value(metadata ptr %39, metadata !472, metadata !DIExpression()), !dbg !474
  br i1 %44, label %133, label %45, !dbg !463

45:                                               ; preds = %38
  %46 = load i8, ptr %39, align 4, !dbg !476
  %47 = shl i8 %46, 2, !dbg !477
  %48 = and i8 %47, 60, !dbg !477
  call void @llvm.dbg.value(metadata i8 %48, metadata !473, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !474
  %49 = icmp ult i8 %48, 20, !dbg !478
  br i1 %49, label %133, label %50, !dbg !480

50:                                               ; preds = %45
  %51 = zext i8 %48 to i64
  call void @llvm.dbg.value(metadata i64 %51, metadata !473, metadata !DIExpression()), !dbg !474
  %52 = getelementptr i8, ptr %39, i64 %51, !dbg !481
  %53 = icmp ugt ptr %52, %9, !dbg !483
  br i1 %53, label %133, label %54, !dbg !484

54:                                               ; preds = %50
  call void @llvm.dbg.value(metadata ptr %52, metadata !377, metadata !DIExpression()), !dbg !392
  %55 = getelementptr inbounds %struct.iphdr, ptr %39, i64 0, i32 6, !dbg !485
  %56 = load i8, ptr %55, align 1, !dbg !485, !tbaa !486
  call void @llvm.dbg.value(metadata i8 %56, metadata !383, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %57 = icmp eq i8 %56, 6, !dbg !488
  br i1 %57, label %58, label %133, !dbg !490

58:                                               ; preds = %54
  call void @llvm.dbg.value(metadata ptr %39, metadata !326, metadata !DIExpression()), !dbg !392
  %59 = getelementptr inbounds %struct.iphdr, ptr %39, i64 0, i32 8, !dbg !491
  %60 = load i32, ptr %59, align 4, !dbg !491, !tbaa !492
  call void @llvm.dbg.value(metadata i32 %60, metadata !384, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata i32 %60, metadata !385, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %61 = lshr i32 %60, 8, !dbg !493
  call void @llvm.dbg.value(metadata !DIArgList(i32 %61, i32 %60), metadata !385, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %62 = lshr i32 %60, 16, !dbg !494
  call void @llvm.dbg.value(metadata !DIArgList(i32 poison, i32 poison), metadata !385, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %63 = lshr i32 %60, 24, !dbg !495
  %64 = xor i32 %61, %62, !dbg !496
  %65 = xor i32 %64, %63, !dbg !496
  %66 = xor i32 %65, %60, !dbg !496
  call void @llvm.dbg.value(metadata i32 %66, metadata !385, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  call void @llvm.dbg.value(metadata i32 %66, metadata !124, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 0, 8)), !dbg !296
  %67 = getelementptr inbounds %struct.iphdr, ptr %39, i64 0, i32 8, i32 0, i32 1, !dbg !497
  %68 = load i32, ptr %67, align 4, !dbg !497, !tbaa !492
  call void @llvm.dbg.value(metadata i32 %68, metadata !386, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata i32 %68, metadata !387, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %69 = lshr i32 %68, 8, !dbg !498
  call void @llvm.dbg.value(metadata !DIArgList(i32 %69, i32 %68), metadata !387, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %70 = lshr i32 %68, 16, !dbg !499
  call void @llvm.dbg.value(metadata !DIArgList(i32 poison, i32 poison), metadata !387, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %71 = lshr i32 %68, 24, !dbg !500
  %72 = xor i32 %69, %70, !dbg !501
  %73 = xor i32 %72, %71, !dbg !501
  %74 = xor i32 %73, %68, !dbg !501
  call void @llvm.dbg.value(metadata i32 %74, metadata !387, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  call void @llvm.dbg.value(metadata i32 %74, metadata !124, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 16, 8)), !dbg !296
  call void @llvm.dbg.value(metadata ptr undef, metadata !502, metadata !DIExpression()), !dbg !512
  call void @llvm.dbg.value(metadata ptr %9, metadata !508, metadata !DIExpression()), !dbg !512
  call void @llvm.dbg.value(metadata ptr undef, metadata !509, metadata !DIExpression()), !dbg !512
  call void @llvm.dbg.value(metadata ptr %52, metadata !511, metadata !DIExpression()), !dbg !512
  %75 = getelementptr inbounds %struct.tcphdr, ptr %52, i64 1, !dbg !515
  %76 = icmp ugt ptr %75, %9, !dbg !517
  br i1 %76, label %133, label %77, !dbg !518

77:                                               ; preds = %58
  %78 = getelementptr inbounds %struct.tcphdr, ptr %52, i64 0, i32 4, !dbg !519
  %79 = load i16, ptr %78, align 4, !dbg !519
  %80 = lshr i16 %79, 2, !dbg !520
  %81 = and i16 %80, 60, !dbg !520
  call void @llvm.dbg.value(metadata i16 %81, metadata !510, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !512
  %82 = icmp ult i16 %81, 20, !dbg !521
  br i1 %82, label %133, label %83, !dbg !523

83:                                               ; preds = %77
  %84 = zext i16 %81 to i64
  %85 = getelementptr i8, ptr %52, i64 %84, !dbg !524
  %86 = icmp ugt ptr %85, %9, !dbg !526
  br i1 %86, label %133, label %87, !dbg !527

87:                                               ; preds = %83
  call void @llvm.dbg.value(metadata ptr %85, metadata !377, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata ptr %52, metadata !355, metadata !DIExpression()), !dbg !392
  %88 = load i16, ptr %52, align 4, !dbg !528, !tbaa !529
  %89 = tail call i16 @llvm.bswap.i16(i16 %88), !dbg !528
  call void @llvm.dbg.value(metadata i16 %89, metadata !388, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata i16 %89, metadata !389, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %90 = lshr i16 %89, 8
  call void @llvm.dbg.value(metadata !DIArgList(i16 %90, i16 %89), metadata !389, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  call void @llvm.dbg.value(metadata !DIArgList(i16 %90, i16 %89), metadata !124, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 8, 8)), !dbg !296
  %91 = getelementptr inbounds %struct.tcphdr, ptr %52, i64 0, i32 1, !dbg !531
  %92 = load i16, ptr %91, align 2, !dbg !531, !tbaa !532
  %93 = tail call i16 @llvm.bswap.i16(i16 %92), !dbg !531
  call void @llvm.dbg.value(metadata i16 %93, metadata !390, metadata !DIExpression()), !dbg !392
  call void @llvm.dbg.value(metadata i16 %93, metadata !391, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  %94 = lshr i16 %93, 8
  call void @llvm.dbg.value(metadata !DIArgList(i16 %94, i16 %93), metadata !391, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !392
  call void @llvm.dbg.value(metadata i32 %66, metadata !124, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 0, 8)), !dbg !296
  call void @llvm.dbg.value(metadata !DIArgList(i16 %90, i16 %89), metadata !124, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 8, 8)), !dbg !296
  call void @llvm.dbg.value(metadata i32 %74, metadata !124, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 16, 8)), !dbg !296
  call void @llvm.dbg.value(metadata !DIArgList(i16 %94, i16 %93), metadata !124, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 24, 8)), !dbg !296
  %95 = and i32 %66, 255, !dbg !533
  %96 = and i32 %74, 255, !dbg !533
  %97 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @rx_module.____fmt, i32 noundef 6, i32 noundef %95, i32 noundef %96) #5, !dbg !533
  %98 = and i16 %89, 255, !dbg !535
  %99 = xor i16 %90, %98, !dbg !535
  %100 = zext i16 %99 to i32, !dbg !535
  %101 = and i16 %93, 255, !dbg !535
  %102 = xor i16 %94, %101, !dbg !535
  %103 = zext i16 %102 to i32, !dbg !535
  %104 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @rx_module.____fmt.1, i32 noundef 6, i32 noundef %100, i32 noundef %103) #5, !dbg !535
  %105 = tail call i32 inttoptr (i64 8 to ptr)() #5, !dbg !537
  call void @llvm.dbg.value(metadata i32 %105, metadata !130, metadata !DIExpression()), !dbg !296
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !538
  call void @llvm.dbg.value(metadata i32 %105, metadata !236, metadata !DIExpression()), !dbg !538
  store i32 %105, ptr %2, align 4, !tbaa !305
  call void @llvm.dbg.value(metadata ptr %2, metadata !236, metadata !DIExpression(DW_OP_deref)), !dbg !538
  %106 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @timer_array, ptr noundef nonnull %2) #5, !dbg !540
  call void @llvm.dbg.value(metadata ptr %106, metadata !237, metadata !DIExpression()), !dbg !538
  %107 = icmp eq ptr %106, null, !dbg !541
  br i1 %107, label %108, label %110, !dbg !543

108:                                              ; preds = %87
  %109 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @initialize_timer.____fmt, i32 noundef 30) #5, !dbg !544
  br label %123, !dbg !547

110:                                              ; preds = %87
  %111 = getelementptr inbounds %struct.timer_event, ptr %106, i64 0, i32 2, !dbg !548
  %112 = call i64 inttoptr (i64 169 to ptr)(ptr noundef nonnull %111, ptr noundef nonnull @timer_array, i64 noundef 7) #5, !dbg !549
  call void @llvm.dbg.value(metadata i64 %112, metadata !238, metadata !DIExpression()), !dbg !538
  %113 = icmp eq i64 %112, 0, !dbg !550
  br i1 %113, label %116, label %114, !dbg !552

114:                                              ; preds = %110
  %115 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @initialize_timer.____fmt.3, i32 noundef 36, i64 noundef %112) #5, !dbg !553
  br label %116, !dbg !556

116:                                              ; preds = %114, %110
  %117 = call i64 inttoptr (i64 170 to ptr)(ptr noundef nonnull %111, ptr noundef nonnull @timer_triggered) #5, !dbg !557
  call void @llvm.dbg.value(metadata i64 %117, metadata !238, metadata !DIExpression()), !dbg !538
  %118 = icmp eq i64 %117, 0, !dbg !558
  br i1 %118, label %121, label %119, !dbg !560

119:                                              ; preds = %116
  %120 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @initialize_timer.____fmt.4, i32 noundef 34, i64 noundef %117) #5, !dbg !561
  br label %121, !dbg !564

121:                                              ; preds = %119, %116
  %122 = call i64 inttoptr (i64 171 to ptr)(ptr noundef nonnull %111, i64 noundef 1000000000, i64 noundef 0) #5, !dbg !565
  br label %123

123:                                              ; preds = %108, %121
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !566
  call void @llvm.dbg.value(metadata ptr %3, metadata !123, metadata !DIExpression(DW_OP_deref)), !dbg !296
  %124 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @xsks_map, ptr noundef nonnull %3) #5, !dbg !567
  %125 = icmp eq ptr %124, null, !dbg !567
  br i1 %125, label %133, label %126, !dbg !569

126:                                              ; preds = %123
  %127 = load i32, ptr %3, align 4, !dbg !570, !tbaa !305
  call void @llvm.dbg.value(metadata i32 %127, metadata !123, metadata !DIExpression()), !dbg !296
  %128 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @rx_module.____fmt.2, i32 noundef 11, i32 noundef %105, i32 noundef %127) #5, !dbg !570
  %129 = load i32, ptr %3, align 4, !dbg !573, !tbaa !305
  call void @llvm.dbg.value(metadata i32 %129, metadata !123, metadata !DIExpression()), !dbg !296
  %130 = sext i32 %129 to i64, !dbg !573
  %131 = call i64 inttoptr (i64 51 to ptr)(ptr noundef nonnull @xsks_map, i64 noundef %130, i64 noundef 0) #5, !dbg !574
  %132 = trunc i64 %131 to i32, !dbg !574
  br label %133, !dbg !575

133:                                              ; preds = %83, %77, %58, %50, %45, %1, %54, %38, %126, %123
  %134 = phi i32 [ %132, %126 ], [ 2, %123 ], [ 1, %38 ], [ 1, %54 ], [ 1, %1 ], [ 1, %45 ], [ 1, %50 ], [ 1, %58 ], [ 1, %77 ], [ 1, %83 ], !dbg !296
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3) #5, !dbg !576
  ret i32 %134, !dbg !576
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: nounwind
define internal i32 @timer_triggered(ptr nocapture readnone %0, ptr nocapture noundef readonly %1, ptr nocapture readnone %2) #0 !dbg !265 {
  call void @llvm.dbg.value(metadata ptr poison, metadata !269, metadata !DIExpression()), !dbg !577
  call void @llvm.dbg.value(metadata ptr %1, metadata !270, metadata !DIExpression()), !dbg !577
  call void @llvm.dbg.value(metadata ptr poison, metadata !271, metadata !DIExpression()), !dbg !577
  %4 = load i32, ptr %1, align 4, !dbg !578, !tbaa !305
  %5 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @timer_triggered.____fmt, i32 noundef 8, i32 noundef %4) #5, !dbg !578
  ret i32 0, !dbg !580
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

; Function Attrs: nounwind memory(none)
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #4

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind memory(none) }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!290, !291, !292, !293}
!llvm.ident = !{!294}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "inner_app_array0", scope: !2, file: !3, line: 33, type: !81, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !45, globals: !51, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kernel_xdp.c", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "a2dad9bb3fe6f0c4db9b850b5e7168ce")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 5436, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "3810ac036d82ed3898d498c10e871015")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 28, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/linux/in.h", directory: "", checksumkind: CSK_MD5, checksum: "078a32220dc819f6a7e2ea3cecc4e133")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!38 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!39 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!40 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!41 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!42 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!43 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!44 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!45 = !{!46, !47, !48}
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!47 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!48 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !49, line: 24, baseType: !50)
!49 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!50 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!51 = !{!52, !107, !136, !138, !143, !148, !0, !164, !166, !168, !170, !172, !174, !176, !178, !180, !182, !184, !186, !188, !190, !192, !194, !196, !198, !200, !202, !218, !225, !230, !242, !247, !252, !258, !263, !273, !278, !285}
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(name: "outer_app_hash", scope: !2, file: !3, line: 44, type: !54, isLocal: false, isDefinition: true)
!54 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_app_hash", file: !3, line: 39, size: 192, elements: !55)
!55 = !{!56, !62, !73, !78}
!56 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !54, file: !3, line: 40, baseType: !57, size: 64)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 416, elements: !60)
!59 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!60 = !{!61}
!61 = !DISubrange(count: 13)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !54, file: !3, line: 41, baseType: !63, size: 64, offset: 64)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "flow_id", file: !65, line: 8, size: 32, elements: !66)
!65 = !DIFile(filename: "./common_def.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "62e78461d85c7c997e0ee9680931bf3a")
!66 = !{!67, !70, !71, !72}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip", scope: !64, file: !65, line: 9, baseType: !68, size: 8)
!68 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !49, line: 21, baseType: !69)
!69 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !64, file: !65, line: 10, baseType: !68, size: 8, offset: 8)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "dest_ip", scope: !64, file: !65, line: 11, baseType: !68, size: 8, offset: 16)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "dest_port", scope: !64, file: !65, line: 12, baseType: !68, size: 8, offset: 24)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !54, file: !3, line: 42, baseType: !74, size: 64, offset: 128)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 640, elements: !76)
!76 = !{!77}
!77 = !DISubrange(count: 20)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !54, file: !3, line: 43, baseType: !79, offset: 192)
!79 = !DICompositeType(tag: DW_TAG_array_type, baseType: !80, elements: !105)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_app_array", file: !3, line: 28, size: 256, elements: !82)
!82 = !{!83, !88, !91, !100}
!83 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !81, file: !3, line: 29, baseType: !84, size: 64)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 64, elements: !86)
!86 = !{!87}
!87 = !DISubrange(count: 2)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !81, file: !3, line: 30, baseType: !89, size: 64, offset: 64)
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !49, line: 27, baseType: !7)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !81, file: !3, line: 31, baseType: !92, size: 64, offset: 128)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!93 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "app_event", file: !65, line: 19, size: 192, elements: !94)
!94 = !{!95, !96, !99}
!95 = !DIDerivedType(tag: DW_TAG_member, name: "ev_flow_id", scope: !93, file: !65, line: 20, baseType: !64, size: 32)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "occupied", scope: !93, file: !65, line: 21, baseType: !97, size: 64, offset: 64)
!97 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !49, line: 31, baseType: !98)
!98 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !93, file: !65, line: 22, baseType: !97, size: 64, offset: 128)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !81, file: !3, line: 32, baseType: !101, size: 64, offset: 192)
!101 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !102, size: 64)
!102 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 3200, elements: !103)
!103 = !{!104}
!104 = !DISubrange(count: 100)
!105 = !{!106}
!106 = !DISubrange(count: -1)
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(name: "____fmt", scope: !109, file: !3, line: 230, type: !131, isLocal: true, isDefinition: true)
!109 = distinct !DISubprogram(name: "rx_module", scope: !3, file: !3, line: 222, type: !110, scopeLine: 223, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !121)
!110 = !DISubroutineType(types: !111)
!111 = !{!59, !112}
!112 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !113, size: 64)
!113 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5447, size: 192, elements: !114)
!114 = !{!115, !116, !117, !118, !119, !120}
!115 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !113, file: !6, line: 5448, baseType: !90, size: 32)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !113, file: !6, line: 5449, baseType: !90, size: 32, offset: 32)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !113, file: !6, line: 5450, baseType: !90, size: 32, offset: 64)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !113, file: !6, line: 5452, baseType: !90, size: 32, offset: 96)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !113, file: !6, line: 5453, baseType: !90, size: 32, offset: 128)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !113, file: !6, line: 5455, baseType: !90, size: 32, offset: 160)
!121 = !{!122, !123, !124, !130}
!122 = !DILocalVariable(name: "ctx", arg: 1, scope: !109, file: !3, line: 222, type: !112)
!123 = !DILocalVariable(name: "index", scope: !109, file: !3, line: 224, type: !59)
!124 = !DILocalVariable(name: "net_ev", scope: !109, file: !3, line: 225, type: !125)
!125 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "net_event", file: !65, line: 25, size: 128, elements: !126)
!126 = !{!127, !128, !129}
!127 = !DIDerivedType(tag: DW_TAG_member, name: "ev_flow_id", scope: !125, file: !65, line: 26, baseType: !64, size: 32)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !125, file: !65, line: 27, baseType: !90, size: 32, offset: 32)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !125, file: !65, line: 28, baseType: !97, size: 64, offset: 64)
!130 = !DILocalVariable(name: "cpu", scope: !109, file: !3, line: 237, type: !59)
!131 = !DICompositeType(tag: DW_TAG_array_type, baseType: !132, size: 48, elements: !134)
!132 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !133)
!133 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!134 = !{!135}
!135 = !DISubrange(count: 6)
!136 = !DIGlobalVariableExpression(var: !137, expr: !DIExpression())
!137 = distinct !DIGlobalVariable(name: "____fmt", scope: !109, file: !3, line: 231, type: !131, isLocal: true, isDefinition: true)
!138 = !DIGlobalVariableExpression(var: !139, expr: !DIExpression())
!139 = distinct !DIGlobalVariable(name: "____fmt", scope: !109, file: !3, line: 242, type: !140, isLocal: true, isDefinition: true)
!140 = !DICompositeType(tag: DW_TAG_array_type, baseType: !132, size: 88, elements: !141)
!141 = !{!142}
!142 = !DISubrange(count: 11)
!143 = !DIGlobalVariableExpression(var: !144, expr: !DIExpression())
!144 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 249, type: !145, isLocal: false, isDefinition: true)
!145 = !DICompositeType(tag: DW_TAG_array_type, baseType: !133, size: 32, elements: !146)
!146 = !{!147}
!147 = !DISubrange(count: 4)
!148 = !DIGlobalVariableExpression(var: !149, expr: !DIExpression())
!149 = distinct !DIGlobalVariable(name: "xsks_map", scope: !2, file: !3, line: 26, type: !150, isLocal: false, isDefinition: true)
!150 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 21, size: 256, elements: !151)
!151 = !{!152, !157, !158, !159}
!152 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !150, file: !3, line: 22, baseType: !153, size: 64)
!153 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !154, size: 64)
!154 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 544, elements: !155)
!155 = !{!156}
!156 = !DISubrange(count: 17)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !150, file: !3, line: 23, baseType: !89, size: 64, offset: 64)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !150, file: !3, line: 24, baseType: !89, size: 64, offset: 128)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !150, file: !3, line: 25, baseType: !160, size: 64, offset: 192)
!160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !161, size: 64)
!161 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 256, elements: !162)
!162 = !{!163}
!163 = !DISubrange(count: 8)
!164 = !DIGlobalVariableExpression(var: !165, expr: !DIExpression())
!165 = distinct !DIGlobalVariable(name: "inner_app_array1", scope: !2, file: !3, line: 33, type: !81, isLocal: false, isDefinition: true)
!166 = !DIGlobalVariableExpression(var: !167, expr: !DIExpression())
!167 = distinct !DIGlobalVariable(name: "inner_app_array2", scope: !2, file: !3, line: 33, type: !81, isLocal: false, isDefinition: true)
!168 = !DIGlobalVariableExpression(var: !169, expr: !DIExpression())
!169 = distinct !DIGlobalVariable(name: "inner_app_array3", scope: !2, file: !3, line: 33, type: !81, isLocal: false, isDefinition: true)
!170 = !DIGlobalVariableExpression(var: !171, expr: !DIExpression())
!171 = distinct !DIGlobalVariable(name: "inner_app_array4", scope: !2, file: !3, line: 34, type: !81, isLocal: false, isDefinition: true)
!172 = !DIGlobalVariableExpression(var: !173, expr: !DIExpression())
!173 = distinct !DIGlobalVariable(name: "inner_app_array5", scope: !2, file: !3, line: 34, type: !81, isLocal: false, isDefinition: true)
!174 = !DIGlobalVariableExpression(var: !175, expr: !DIExpression())
!175 = distinct !DIGlobalVariable(name: "inner_app_array6", scope: !2, file: !3, line: 34, type: !81, isLocal: false, isDefinition: true)
!176 = !DIGlobalVariableExpression(var: !177, expr: !DIExpression())
!177 = distinct !DIGlobalVariable(name: "inner_app_array7", scope: !2, file: !3, line: 34, type: !81, isLocal: false, isDefinition: true)
!178 = !DIGlobalVariableExpression(var: !179, expr: !DIExpression())
!179 = distinct !DIGlobalVariable(name: "inner_app_array8", scope: !2, file: !3, line: 35, type: !81, isLocal: false, isDefinition: true)
!180 = !DIGlobalVariableExpression(var: !181, expr: !DIExpression())
!181 = distinct !DIGlobalVariable(name: "inner_app_array9", scope: !2, file: !3, line: 35, type: !81, isLocal: false, isDefinition: true)
!182 = !DIGlobalVariableExpression(var: !183, expr: !DIExpression())
!183 = distinct !DIGlobalVariable(name: "inner_app_array10", scope: !2, file: !3, line: 35, type: !81, isLocal: false, isDefinition: true)
!184 = !DIGlobalVariableExpression(var: !185, expr: !DIExpression())
!185 = distinct !DIGlobalVariable(name: "inner_app_array11", scope: !2, file: !3, line: 35, type: !81, isLocal: false, isDefinition: true)
!186 = !DIGlobalVariableExpression(var: !187, expr: !DIExpression())
!187 = distinct !DIGlobalVariable(name: "inner_app_array12", scope: !2, file: !3, line: 36, type: !81, isLocal: false, isDefinition: true)
!188 = !DIGlobalVariableExpression(var: !189, expr: !DIExpression())
!189 = distinct !DIGlobalVariable(name: "inner_app_array13", scope: !2, file: !3, line: 36, type: !81, isLocal: false, isDefinition: true)
!190 = !DIGlobalVariableExpression(var: !191, expr: !DIExpression())
!191 = distinct !DIGlobalVariable(name: "inner_app_array14", scope: !2, file: !3, line: 36, type: !81, isLocal: false, isDefinition: true)
!192 = !DIGlobalVariableExpression(var: !193, expr: !DIExpression())
!193 = distinct !DIGlobalVariable(name: "inner_app_array15", scope: !2, file: !3, line: 36, type: !81, isLocal: false, isDefinition: true)
!194 = !DIGlobalVariableExpression(var: !195, expr: !DIExpression())
!195 = distinct !DIGlobalVariable(name: "inner_app_array16", scope: !2, file: !3, line: 37, type: !81, isLocal: false, isDefinition: true)
!196 = !DIGlobalVariableExpression(var: !197, expr: !DIExpression())
!197 = distinct !DIGlobalVariable(name: "inner_app_array17", scope: !2, file: !3, line: 37, type: !81, isLocal: false, isDefinition: true)
!198 = !DIGlobalVariableExpression(var: !199, expr: !DIExpression())
!199 = distinct !DIGlobalVariable(name: "inner_app_array18", scope: !2, file: !3, line: 37, type: !81, isLocal: false, isDefinition: true)
!200 = !DIGlobalVariableExpression(var: !201, expr: !DIExpression())
!201 = distinct !DIGlobalVariable(name: "inner_app_array19", scope: !2, file: !3, line: 37, type: !81, isLocal: false, isDefinition: true)
!202 = !DIGlobalVariableExpression(var: !203, expr: !DIExpression())
!203 = distinct !DIGlobalVariable(name: "timer_array", scope: !2, file: !3, line: 65, type: !204, isLocal: false, isDefinition: true)
!204 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 60, size: 256, elements: !205)
!205 = !{!206, !207, !208, !217}
!206 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !204, file: !3, line: 61, baseType: !84, size: 64)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !204, file: !3, line: 62, baseType: !89, size: 64, offset: 64)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !204, file: !3, line: 63, baseType: !209, size: 64, offset: 128)
!209 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !210, size: 64)
!210 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timer_event", file: !3, line: 53, size: 192, elements: !211)
!211 = !{!212, !213, !214}
!212 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !210, file: !3, line: 54, baseType: !59, size: 32)
!213 = !DIDerivedType(tag: DW_TAG_member, name: "index", scope: !210, file: !3, line: 55, baseType: !59, size: 32, offset: 32)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "timer", scope: !210, file: !3, line: 56, baseType: !215, size: 128, align: 64, offset: 64)
!215 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_timer", file: !6, line: 6190, size: 128, align: 64, elements: !216)
!216 = !{}
!217 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !204, file: !3, line: 64, baseType: !160, size: 64, offset: 192)
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !220, line: 177, type: !221, isLocal: true, isDefinition: true)
!220 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!221 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !222, size: 64)
!222 = !DISubroutineType(types: !223)
!223 = !{!47, !224, !90, null}
!224 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !132, size: 64)
!225 = !DIGlobalVariableExpression(var: !226, expr: !DIExpression())
!226 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !220, line: 206, type: !227, isLocal: true, isDefinition: true)
!227 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !228, size: 64)
!228 = !DISubroutineType(types: !229)
!229 = !{!90}
!230 = !DIGlobalVariableExpression(var: !231, expr: !DIExpression())
!231 = distinct !DIGlobalVariable(name: "____fmt", scope: !232, file: !3, line: 183, type: !239, isLocal: true, isDefinition: true)
!232 = distinct !DISubprogram(name: "initialize_timer", scope: !3, file: !3, line: 178, type: !233, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !235)
!233 = !DISubroutineType(types: !234)
!234 = !{!59, !59}
!235 = !{!236, !237, !238}
!236 = !DILocalVariable(name: "cpu", arg: 1, scope: !232, file: !3, line: 178, type: !59)
!237 = !DILocalVariable(name: "map_entry", scope: !232, file: !3, line: 179, type: !209)
!238 = !DILocalVariable(name: "i", scope: !232, file: !3, line: 187, type: !47)
!239 = !DICompositeType(tag: DW_TAG_array_type, baseType: !132, size: 240, elements: !240)
!240 = !{!241}
!241 = !DISubrange(count: 30)
!242 = !DIGlobalVariableExpression(var: !243, expr: !DIExpression())
!243 = distinct !DIGlobalVariable(name: "____fmt", scope: !232, file: !3, line: 189, type: !244, isLocal: true, isDefinition: true)
!244 = !DICompositeType(tag: DW_TAG_array_type, baseType: !132, size: 288, elements: !245)
!245 = !{!246}
!246 = !DISubrange(count: 36)
!247 = !DIGlobalVariableExpression(var: !248, expr: !DIExpression())
!248 = distinct !DIGlobalVariable(name: "____fmt", scope: !232, file: !3, line: 195, type: !249, isLocal: true, isDefinition: true)
!249 = !DICompositeType(tag: DW_TAG_array_type, baseType: !132, size: 272, elements: !250)
!250 = !{!251}
!251 = !DISubrange(count: 34)
!252 = !DIGlobalVariableExpression(var: !253, expr: !DIExpression())
!253 = distinct !DIGlobalVariable(name: "bpf_timer_init", scope: !2, file: !220, line: 3992, type: !254, isLocal: true, isDefinition: true)
!254 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !255, size: 64)
!255 = !DISubroutineType(types: !256)
!256 = !{!47, !257, !46, !97}
!257 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !215, size: 64)
!258 = !DIGlobalVariableExpression(var: !259, expr: !DIExpression())
!259 = distinct !DIGlobalVariable(name: "bpf_timer_set_callback", scope: !2, file: !220, line: 4007, type: !260, isLocal: true, isDefinition: true)
!260 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!261 = !DISubroutineType(types: !262)
!262 = !{!47, !257, !46}
!263 = !DIGlobalVariableExpression(var: !264, expr: !DIExpression())
!264 = distinct !DIGlobalVariable(name: "____fmt", scope: !265, file: !3, line: 174, type: !272, isLocal: true, isDefinition: true)
!265 = distinct !DISubprogram(name: "timer_triggered", scope: !3, file: !3, line: 173, type: !266, scopeLine: 173, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !268)
!266 = !DISubroutineType(types: !267)
!267 = !{!59, !46, !89, !209}
!268 = !{!269, !270, !271}
!269 = !DILocalVariable(name: "map", arg: 1, scope: !265, file: !3, line: 173, type: !46)
!270 = !DILocalVariable(name: "key", arg: 2, scope: !265, file: !3, line: 173, type: !89)
!271 = !DILocalVariable(name: "val", arg: 3, scope: !265, file: !3, line: 173, type: !209)
!272 = !DICompositeType(tag: DW_TAG_array_type, baseType: !132, size: 64, elements: !162)
!273 = !DIGlobalVariableExpression(var: !274, expr: !DIExpression())
!274 = distinct !DIGlobalVariable(name: "bpf_timer_start", scope: !2, file: !220, line: 4043, type: !275, isLocal: true, isDefinition: true)
!275 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !276, size: 64)
!276 = !DISubroutineType(types: !277)
!277 = !{!47, !257, !97, !97}
!278 = !DIGlobalVariableExpression(var: !279, expr: !DIExpression())
!279 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !220, line: 56, type: !280, isLocal: true, isDefinition: true)
!280 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !281, size: 64)
!281 = !DISubroutineType(types: !282)
!282 = !{!46, !46, !283}
!283 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !284, size: 64)
!284 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!285 = !DIGlobalVariableExpression(var: !286, expr: !DIExpression())
!286 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !220, line: 1323, type: !287, isLocal: true, isDefinition: true)
!287 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !288, size: 64)
!288 = !DISubroutineType(types: !289)
!289 = !{!47, !46, !97, !97}
!290 = !{i32 7, !"Dwarf Version", i32 5}
!291 = !{i32 2, !"Debug Info Version", i32 3}
!292 = !{i32 1, !"wchar_size", i32 4}
!293 = !{i32 7, !"frame-pointer", i32 2}
!294 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!295 = !DILocation(line: 225, column: 22, scope: !109)
!296 = !DILocation(line: 0, scope: !109)
!297 = !DILocation(line: 224, column: 5, scope: !109)
!298 = !DILocation(line: 224, column: 22, scope: !109)
!299 = !{!300, !301, i64 16}
!300 = !{!"xdp_md", !301, i64 0, !301, i64 4, !301, i64 8, !301, i64 12, !301, i64 16, !301, i64 20}
!301 = !{!"int", !302, i64 0}
!302 = !{!"omnipotent char", !303, i64 0}
!303 = !{!"Simple C/C++ TBAA"}
!304 = !DILocation(line: 224, column: 9, scope: !109)
!305 = !{!301, !301, i64 0}
!306 = !DILocalVariable(name: "ctx", arg: 1, scope: !307, file: !3, line: 68, type: !112)
!307 = distinct !DISubprogram(name: "parse_packet", scope: !3, file: !3, line: 68, type: !308, scopeLine: 68, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !311)
!308 = !DISubroutineType(types: !309)
!309 = !{!59, !112, !310}
!310 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!311 = !{!306, !312, !313, !314, !315, !326, !355, !377, !382, !383, !384, !385, !386, !387, !388, !389, !390, !391}
!312 = !DILocalVariable(name: "net_ev", arg: 2, scope: !307, file: !3, line: 68, type: !310)
!313 = !DILocalVariable(name: "data_end", scope: !307, file: !3, line: 69, type: !46)
!314 = !DILocalVariable(name: "data", scope: !307, file: !3, line: 70, type: !46)
!315 = !DILocalVariable(name: "eth", scope: !307, file: !3, line: 74, type: !316)
!316 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !317, size: 64)
!317 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !318, line: 168, size: 112, elements: !319)
!318 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!319 = !{!320, !322, !323}
!320 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !317, file: !318, line: 169, baseType: !321, size: 48)
!321 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 48, elements: !134)
!322 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !317, file: !318, line: 170, baseType: !321, size: 48, offset: 48)
!323 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !317, file: !318, line: 171, baseType: !324, size: 16, offset: 96)
!324 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !325, line: 25, baseType: !48)
!325 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!326 = !DILocalVariable(name: "iphdr", scope: !307, file: !3, line: 75, type: !327)
!327 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !328, size: 64)
!328 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !329, line: 87, size: 160, elements: !330)
!329 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "042b09a58768855e3578a0a8eba49be7")
!330 = !{!331, !332, !333, !334, !335, !336, !337, !338, !339, !341}
!331 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !328, file: !329, line: 89, baseType: !68, size: 4, flags: DIFlagBitField, extraData: i64 0)
!332 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !328, file: !329, line: 90, baseType: !68, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!333 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !328, file: !329, line: 97, baseType: !68, size: 8, offset: 8)
!334 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !328, file: !329, line: 98, baseType: !324, size: 16, offset: 16)
!335 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !328, file: !329, line: 99, baseType: !324, size: 16, offset: 32)
!336 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !328, file: !329, line: 100, baseType: !324, size: 16, offset: 48)
!337 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !328, file: !329, line: 101, baseType: !68, size: 8, offset: 64)
!338 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !328, file: !329, line: 102, baseType: !68, size: 8, offset: 72)
!339 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !328, file: !329, line: 103, baseType: !340, size: 16, offset: 80)
!340 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !325, line: 31, baseType: !48)
!341 = !DIDerivedType(tag: DW_TAG_member, scope: !328, file: !329, line: 104, baseType: !342, size: 64, offset: 96)
!342 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !328, file: !329, line: 104, size: 64, elements: !343)
!343 = !{!344, !350}
!344 = !DIDerivedType(tag: DW_TAG_member, scope: !342, file: !329, line: 104, baseType: !345, size: 64)
!345 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !342, file: !329, line: 104, size: 64, elements: !346)
!346 = !{!347, !349}
!347 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !345, file: !329, line: 104, baseType: !348, size: 32)
!348 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !325, line: 27, baseType: !90)
!349 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !345, file: !329, line: 104, baseType: !348, size: 32, offset: 32)
!350 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !342, file: !329, line: 104, baseType: !351, size: 64)
!351 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !342, file: !329, line: 104, size: 64, elements: !352)
!352 = !{!353, !354}
!353 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !351, file: !329, line: 104, baseType: !348, size: 32)
!354 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !351, file: !329, line: 104, baseType: !348, size: 32, offset: 32)
!355 = !DILocalVariable(name: "tcph", scope: !307, file: !3, line: 76, type: !356)
!356 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !357, size: 64)
!357 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !358, line: 25, size: 160, elements: !359)
!358 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "", checksumkind: CSK_MD5, checksum: "8d74bf2133e7b3dab885994b9916aa13")
!359 = !{!360, !361, !362, !363, !364, !365, !366, !367, !368, !369, !370, !371, !372, !373, !374, !375, !376}
!360 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !357, file: !358, line: 26, baseType: !324, size: 16)
!361 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !357, file: !358, line: 27, baseType: !324, size: 16, offset: 16)
!362 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !357, file: !358, line: 28, baseType: !348, size: 32, offset: 32)
!363 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !357, file: !358, line: 29, baseType: !348, size: 32, offset: 64)
!364 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !357, file: !358, line: 31, baseType: !48, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!365 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !357, file: !358, line: 32, baseType: !48, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!366 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !357, file: !358, line: 33, baseType: !48, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!367 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !357, file: !358, line: 34, baseType: !48, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!368 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !357, file: !358, line: 35, baseType: !48, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!369 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !357, file: !358, line: 36, baseType: !48, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!370 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !357, file: !358, line: 37, baseType: !48, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!371 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !357, file: !358, line: 38, baseType: !48, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!372 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !357, file: !358, line: 39, baseType: !48, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!373 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !357, file: !358, line: 40, baseType: !48, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!374 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !357, file: !358, line: 55, baseType: !324, size: 16, offset: 112)
!375 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !357, file: !358, line: 56, baseType: !340, size: 16, offset: 128)
!376 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !357, file: !358, line: 57, baseType: !324, size: 16, offset: 144)
!377 = !DILocalVariable(name: "nh", scope: !307, file: !3, line: 78, type: !378)
!378 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !379, line: 33, size: 64, elements: !380)
!379 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "172efdd203783aed49c0ce78645261a8")
!380 = !{!381}
!381 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !378, file: !379, line: 34, baseType: !46, size: 64)
!382 = !DILocalVariable(name: "eth_type", scope: !307, file: !3, line: 79, type: !59)
!383 = !DILocalVariable(name: "ip_type", scope: !307, file: !3, line: 79, type: !59)
!384 = !DILocalVariable(name: "saddr", scope: !307, file: !3, line: 110, type: !348)
!385 = !DILocalVariable(name: "src_ip", scope: !307, file: !3, line: 111, type: !68)
!386 = !DILocalVariable(name: "daddr", scope: !307, file: !3, line: 126, type: !348)
!387 = !DILocalVariable(name: "dst_ip", scope: !307, file: !3, line: 127, type: !68)
!388 = !DILocalVariable(name: "sport", scope: !307, file: !3, line: 152, type: !324)
!389 = !DILocalVariable(name: "src_port", scope: !307, file: !3, line: 153, type: !68)
!390 = !DILocalVariable(name: "dport", scope: !307, file: !3, line: 158, type: !324)
!391 = !DILocalVariable(name: "dst_port", scope: !307, file: !3, line: 159, type: !68)
!392 = !DILocation(line: 0, scope: !307, inlinedAt: !393)
!393 = distinct !DILocation(line: 227, column: 9, scope: !394)
!394 = distinct !DILexicalBlock(scope: !109, file: !3, line: 227, column: 8)
!395 = !DILocation(line: 69, column: 41, scope: !307, inlinedAt: !393)
!396 = !{!300, !301, i64 4}
!397 = !DILocation(line: 69, column: 30, scope: !307, inlinedAt: !393)
!398 = !DILocation(line: 69, column: 22, scope: !307, inlinedAt: !393)
!399 = !DILocation(line: 70, column: 41, scope: !307, inlinedAt: !393)
!400 = !{!300, !301, i64 0}
!401 = !DILocation(line: 70, column: 30, scope: !307, inlinedAt: !393)
!402 = !DILocation(line: 70, column: 22, scope: !307, inlinedAt: !393)
!403 = !DILocalVariable(name: "nh", arg: 1, scope: !404, file: !379, line: 124, type: !407)
!404 = distinct !DISubprogram(name: "parse_ethhdr", scope: !379, file: !379, line: 124, type: !405, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !409)
!405 = !DISubroutineType(types: !406)
!406 = !{!59, !407, !46, !408}
!407 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !378, size: 64)
!408 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !316, size: 64)
!409 = !{!403, !410, !411}
!410 = !DILocalVariable(name: "data_end", arg: 2, scope: !404, file: !379, line: 125, type: !46)
!411 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !404, file: !379, line: 126, type: !408)
!412 = !DILocation(line: 0, scope: !404, inlinedAt: !413)
!413 = distinct !DILocation(line: 83, column: 16, scope: !307, inlinedAt: !393)
!414 = !DILocalVariable(name: "nh", arg: 1, scope: !415, file: !379, line: 79, type: !407)
!415 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !379, file: !379, line: 79, type: !416, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !423)
!416 = !DISubroutineType(types: !417)
!417 = !{!59, !407, !46, !408, !418}
!418 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !419, size: 64)
!419 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !379, line: 64, size: 32, elements: !420)
!420 = !{!421}
!421 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !419, file: !379, line: 65, baseType: !422, size: 32)
!422 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 32, elements: !86)
!423 = !{!414, !424, !425, !426, !427, !428, !429, !435, !436}
!424 = !DILocalVariable(name: "data_end", arg: 2, scope: !415, file: !379, line: 80, type: !46)
!425 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !415, file: !379, line: 81, type: !408)
!426 = !DILocalVariable(name: "vlans", arg: 4, scope: !415, file: !379, line: 82, type: !418)
!427 = !DILocalVariable(name: "eth", scope: !415, file: !379, line: 84, type: !316)
!428 = !DILocalVariable(name: "hdrsize", scope: !415, file: !379, line: 85, type: !59)
!429 = !DILocalVariable(name: "vlh", scope: !415, file: !379, line: 86, type: !430)
!430 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !431, size: 64)
!431 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !379, line: 42, size: 32, elements: !432)
!432 = !{!433, !434}
!433 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !431, file: !379, line: 43, baseType: !324, size: 16)
!434 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !431, file: !379, line: 44, baseType: !324, size: 16, offset: 16)
!435 = !DILocalVariable(name: "h_proto", scope: !415, file: !379, line: 87, type: !48)
!436 = !DILocalVariable(name: "i", scope: !415, file: !379, line: 88, type: !59)
!437 = !DILocation(line: 0, scope: !415, inlinedAt: !438)
!438 = distinct !DILocation(line: 129, column: 9, scope: !404, inlinedAt: !413)
!439 = !DILocation(line: 93, column: 14, scope: !440, inlinedAt: !438)
!440 = distinct !DILexicalBlock(scope: !415, file: !379, line: 93, column: 6)
!441 = !DILocation(line: 93, column: 24, scope: !440, inlinedAt: !438)
!442 = !DILocation(line: 93, column: 6, scope: !415, inlinedAt: !438)
!443 = !DILocation(line: 99, column: 17, scope: !415, inlinedAt: !438)
!444 = !{!445, !445, i64 0}
!445 = !{!"short", !302, i64 0}
!446 = !DILocalVariable(name: "h_proto", arg: 1, scope: !447, file: !379, line: 68, type: !48)
!447 = distinct !DISubprogram(name: "proto_is_vlan", scope: !379, file: !379, line: 68, type: !448, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !450)
!448 = !DISubroutineType(types: !449)
!449 = !{!59, !48}
!450 = !{!446}
!451 = !DILocation(line: 0, scope: !447, inlinedAt: !452)
!452 = distinct !DILocation(line: 106, column: 8, scope: !453, inlinedAt: !438)
!453 = distinct !DILexicalBlock(scope: !454, file: !379, line: 106, column: 7)
!454 = distinct !DILexicalBlock(scope: !455, file: !379, line: 105, column: 39)
!455 = distinct !DILexicalBlock(scope: !456, file: !379, line: 105, column: 2)
!456 = distinct !DILexicalBlock(scope: !415, file: !379, line: 105, column: 2)
!457 = !DILocation(line: 70, column: 20, scope: !447, inlinedAt: !452)
!458 = !DILocation(line: 70, column: 46, scope: !447, inlinedAt: !452)
!459 = !DILocation(line: 106, column: 7, scope: !454, inlinedAt: !438)
!460 = !DILocation(line: 112, column: 18, scope: !454, inlinedAt: !438)
!461 = !DILocation(line: 84, column: 18, scope: !462, inlinedAt: !393)
!462 = distinct !DILexicalBlock(scope: !307, file: !3, line: 84, column: 9)
!463 = !DILocation(line: 84, column: 9, scope: !307, inlinedAt: !393)
!464 = !DILocalVariable(name: "nh", arg: 1, scope: !465, file: !379, line: 151, type: !407)
!465 = distinct !DISubprogram(name: "parse_iphdr", scope: !379, file: !379, line: 151, type: !466, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !469)
!466 = !DISubroutineType(types: !467)
!467 = !{!59, !407, !46, !468}
!468 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !327, size: 64)
!469 = !{!464, !470, !471, !472, !473}
!470 = !DILocalVariable(name: "data_end", arg: 2, scope: !465, file: !379, line: 152, type: !46)
!471 = !DILocalVariable(name: "iphdr", arg: 3, scope: !465, file: !379, line: 153, type: !468)
!472 = !DILocalVariable(name: "iph", scope: !465, file: !379, line: 155, type: !327)
!473 = !DILocalVariable(name: "hdrsize", scope: !465, file: !379, line: 156, type: !59)
!474 = !DILocation(line: 0, scope: !465, inlinedAt: !475)
!475 = distinct !DILocation(line: 101, column: 15, scope: !307, inlinedAt: !393)
!476 = !DILocation(line: 161, column: 17, scope: !465, inlinedAt: !475)
!477 = !DILocation(line: 161, column: 21, scope: !465, inlinedAt: !475)
!478 = !DILocation(line: 163, column: 13, scope: !479, inlinedAt: !475)
!479 = distinct !DILexicalBlock(scope: !465, file: !379, line: 163, column: 5)
!480 = !DILocation(line: 163, column: 5, scope: !465, inlinedAt: !475)
!481 = !DILocation(line: 167, column: 14, scope: !482, inlinedAt: !475)
!482 = distinct !DILexicalBlock(scope: !465, file: !379, line: 167, column: 6)
!483 = !DILocation(line: 167, column: 24, scope: !482, inlinedAt: !475)
!484 = !DILocation(line: 167, column: 6, scope: !465, inlinedAt: !475)
!485 = !DILocation(line: 173, column: 14, scope: !465, inlinedAt: !475)
!486 = !{!487, !302, i64 9}
!487 = !{!"iphdr", !302, i64 0, !302, i64 0, !302, i64 1, !445, i64 2, !445, i64 4, !445, i64 6, !302, i64 8, !302, i64 9, !445, i64 10, !302, i64 12}
!488 = !DILocation(line: 105, column: 16, scope: !489, inlinedAt: !393)
!489 = distinct !DILexicalBlock(scope: !307, file: !3, line: 105, column: 8)
!490 = !DILocation(line: 105, column: 8, scope: !307, inlinedAt: !393)
!491 = !DILocation(line: 110, column: 27, scope: !307, inlinedAt: !393)
!492 = !{!302, !302, i64 0}
!493 = !DILocation(line: 113, column: 22, scope: !307, inlinedAt: !393)
!494 = !DILocation(line: 114, column: 22, scope: !307, inlinedAt: !393)
!495 = !DILocation(line: 115, column: 22, scope: !307, inlinedAt: !393)
!496 = !DILocation(line: 115, column: 37, scope: !307, inlinedAt: !393)
!497 = !DILocation(line: 126, column: 27, scope: !307, inlinedAt: !393)
!498 = !DILocation(line: 129, column: 22, scope: !307, inlinedAt: !393)
!499 = !DILocation(line: 130, column: 22, scope: !307, inlinedAt: !393)
!500 = !DILocation(line: 131, column: 22, scope: !307, inlinedAt: !393)
!501 = !DILocation(line: 131, column: 37, scope: !307, inlinedAt: !393)
!502 = !DILocalVariable(name: "nh", arg: 1, scope: !503, file: !379, line: 247, type: !407)
!503 = distinct !DISubprogram(name: "parse_tcphdr", scope: !379, file: !379, line: 247, type: !504, scopeLine: 250, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !507)
!504 = !DISubroutineType(types: !505)
!505 = !{!59, !407, !46, !506}
!506 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !356, size: 64)
!507 = !{!502, !508, !509, !510, !511}
!508 = !DILocalVariable(name: "data_end", arg: 2, scope: !503, file: !379, line: 248, type: !46)
!509 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !503, file: !379, line: 249, type: !506)
!510 = !DILocalVariable(name: "len", scope: !503, file: !379, line: 251, type: !59)
!511 = !DILocalVariable(name: "h", scope: !503, file: !379, line: 252, type: !356)
!512 = !DILocation(line: 0, scope: !503, inlinedAt: !513)
!513 = distinct !DILocation(line: 147, column: 8, scope: !514, inlinedAt: !393)
!514 = distinct !DILexicalBlock(scope: !307, file: !3, line: 147, column: 8)
!515 = !DILocation(line: 254, column: 8, scope: !516, inlinedAt: !513)
!516 = distinct !DILexicalBlock(scope: !503, file: !379, line: 254, column: 6)
!517 = !DILocation(line: 254, column: 12, scope: !516, inlinedAt: !513)
!518 = !DILocation(line: 254, column: 6, scope: !503, inlinedAt: !513)
!519 = !DILocation(line: 257, column: 11, scope: !503, inlinedAt: !513)
!520 = !DILocation(line: 257, column: 16, scope: !503, inlinedAt: !513)
!521 = !DILocation(line: 259, column: 9, scope: !522, inlinedAt: !513)
!522 = distinct !DILexicalBlock(scope: !503, file: !379, line: 259, column: 5)
!523 = !DILocation(line: 259, column: 5, scope: !503, inlinedAt: !513)
!524 = !DILocation(line: 263, column: 14, scope: !525, inlinedAt: !513)
!525 = distinct !DILexicalBlock(scope: !503, file: !379, line: 263, column: 6)
!526 = !DILocation(line: 263, column: 20, scope: !525, inlinedAt: !513)
!527 = !DILocation(line: 263, column: 6, scope: !503, inlinedAt: !513)
!528 = !DILocation(line: 152, column: 20, scope: !307, inlinedAt: !393)
!529 = !{!530, !445, i64 0}
!530 = !{!"tcphdr", !445, i64 0, !445, i64 2, !301, i64 4, !301, i64 8, !445, i64 12, !445, i64 12, !445, i64 13, !445, i64 13, !445, i64 13, !445, i64 13, !445, i64 13, !445, i64 13, !445, i64 13, !445, i64 13, !445, i64 14, !445, i64 16, !445, i64 18}
!531 = !DILocation(line: 158, column: 20, scope: !307, inlinedAt: !393)
!532 = !{!530, !445, i64 2}
!533 = !DILocation(line: 230, column: 5, scope: !534)
!534 = distinct !DILexicalBlock(scope: !109, file: !3, line: 230, column: 5)
!535 = !DILocation(line: 231, column: 5, scope: !536)
!536 = distinct !DILexicalBlock(scope: !109, file: !3, line: 231, column: 5)
!537 = !DILocation(line: 237, column: 15, scope: !109)
!538 = !DILocation(line: 0, scope: !232, inlinedAt: !539)
!539 = distinct !DILocation(line: 239, column: 5, scope: !109)
!540 = !DILocation(line: 181, column: 17, scope: !232, inlinedAt: !539)
!541 = !DILocation(line: 182, column: 9, scope: !542, inlinedAt: !539)
!542 = distinct !DILexicalBlock(scope: !232, file: !3, line: 182, column: 8)
!543 = !DILocation(line: 182, column: 8, scope: !232, inlinedAt: !539)
!544 = !DILocation(line: 183, column: 9, scope: !545, inlinedAt: !539)
!545 = distinct !DILexicalBlock(scope: !546, file: !3, line: 183, column: 9)
!546 = distinct !DILexicalBlock(scope: !542, file: !3, line: 182, column: 20)
!547 = !DILocation(line: 184, column: 9, scope: !546, inlinedAt: !539)
!548 = !DILocation(line: 187, column: 45, scope: !232, inlinedAt: !539)
!549 = !DILocation(line: 187, column: 18, scope: !232, inlinedAt: !539)
!550 = !DILocation(line: 188, column: 10, scope: !551, inlinedAt: !539)
!551 = distinct !DILexicalBlock(scope: !232, file: !3, line: 188, column: 8)
!552 = !DILocation(line: 188, column: 8, scope: !232, inlinedAt: !539)
!553 = !DILocation(line: 189, column: 9, scope: !554, inlinedAt: !539)
!554 = distinct !DILexicalBlock(scope: !555, file: !3, line: 189, column: 9)
!555 = distinct !DILexicalBlock(scope: !551, file: !3, line: 188, column: 16)
!556 = !DILocation(line: 190, column: 5, scope: !555, inlinedAt: !539)
!557 = !DILocation(line: 193, column: 9, scope: !232, inlinedAt: !539)
!558 = !DILocation(line: 194, column: 10, scope: !559, inlinedAt: !539)
!559 = distinct !DILexicalBlock(scope: !232, file: !3, line: 194, column: 8)
!560 = !DILocation(line: 194, column: 8, scope: !232, inlinedAt: !539)
!561 = !DILocation(line: 195, column: 9, scope: !562, inlinedAt: !539)
!562 = distinct !DILexicalBlock(scope: !563, file: !3, line: 195, column: 9)
!563 = distinct !DILexicalBlock(scope: !559, file: !3, line: 194, column: 16)
!564 = !DILocation(line: 196, column: 5, scope: !563, inlinedAt: !539)
!565 = !DILocation(line: 199, column: 5, scope: !232, inlinedAt: !539)
!566 = !DILocation(line: 202, column: 1, scope: !232, inlinedAt: !539)
!567 = !DILocation(line: 241, column: 9, scope: !568)
!568 = distinct !DILexicalBlock(scope: !109, file: !3, line: 241, column: 9)
!569 = !DILocation(line: 241, column: 9, scope: !109)
!570 = !DILocation(line: 242, column: 9, scope: !571)
!571 = distinct !DILexicalBlock(scope: !572, file: !3, line: 242, column: 9)
!572 = distinct !DILexicalBlock(scope: !568, file: !3, line: 241, column: 49)
!573 = !DILocation(line: 243, column: 44, scope: !572)
!574 = !DILocation(line: 243, column: 16, scope: !572)
!575 = !DILocation(line: 243, column: 9, scope: !572)
!576 = !DILocation(line: 247, column: 1, scope: !109)
!577 = !DILocation(line: 0, scope: !265)
!578 = !DILocation(line: 174, column: 5, scope: !579)
!579 = distinct !DILexicalBlock(scope: !265, file: !3, line: 174, column: 5)
!580 = !DILocation(line: 175, column: 5, scope: !265)
