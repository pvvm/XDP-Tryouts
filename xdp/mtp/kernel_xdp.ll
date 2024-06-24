; ModuleID = 'kernel_xdp.c'
source_filename = "kernel_xdp.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.inner_app_array = type { ptr, ptr, ptr, ptr }
%struct.anon = type { ptr, ptr, ptr, ptr }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, %union.anon }
%union.anon = type { %struct.anon.0 }
%struct.anon.0 = type { i32, i32 }
%struct.tcphdr = type { i16, i16, i32, i32, i16, i16, i16, i16 }

@inner_app_array0 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !0
@inner_app_array1 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !145
@inner_app_array2 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !147
@inner_app_array3 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !149
@inner_app_array4 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !151
@inner_app_array5 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !153
@inner_app_array6 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !155
@inner_app_array7 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !157
@inner_app_array8 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !159
@inner_app_array9 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !161
@inner_app_array10 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !163
@inner_app_array11 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !165
@inner_app_array12 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !167
@inner_app_array13 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !169
@inner_app_array14 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !171
@inner_app_array15 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !173
@inner_app_array16 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !175
@inner_app_array17 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !177
@inner_app_array18 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !179
@inner_app_array19 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !181
@outer_app_hash = dso_local global { ptr, ptr, ptr, [20 x ptr] } { ptr null, ptr null, ptr null, [20 x ptr] [ptr @inner_app_array0, ptr @inner_app_array1, ptr @inner_app_array2, ptr @inner_app_array3, ptr @inner_app_array4, ptr @inner_app_array5, ptr @inner_app_array6, ptr @inner_app_array7, ptr @inner_app_array8, ptr @inner_app_array9, ptr @inner_app_array10, ptr @inner_app_array11, ptr @inner_app_array12, ptr @inner_app_array13, ptr @inner_app_array14, ptr @inner_app_array15, ptr @inner_app_array16, ptr @inner_app_array17, ptr @inner_app_array18, ptr @inner_app_array19] }, section ".maps", align 8, !dbg !52
@xsks_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !129
@xdp_sock_prog.____fmt = internal constant [11 x i8] c"TEST %d %d\00", align 1, !dbg !101
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !124
@parse_packet.____fmt = internal constant [24 x i8] c"\0ADestination port: %d\0A\0A\00", align 1, !dbg !183
@parse_packet.____fmt.1 = internal constant [24 x i8] c"\0ADestination port: %d\0A\0A\00", align 1, !dbg !271
@llvm.compiler.used = appending global [24 x ptr] [ptr @_license, ptr @inner_app_array0, ptr @inner_app_array1, ptr @inner_app_array10, ptr @inner_app_array11, ptr @inner_app_array12, ptr @inner_app_array13, ptr @inner_app_array14, ptr @inner_app_array15, ptr @inner_app_array16, ptr @inner_app_array17, ptr @inner_app_array18, ptr @inner_app_array19, ptr @inner_app_array2, ptr @inner_app_array3, ptr @inner_app_array4, ptr @inner_app_array5, ptr @inner_app_array6, ptr @inner_app_array7, ptr @inner_app_array8, ptr @inner_app_array9, ptr @outer_app_hash, ptr @xdp_sock_prog, ptr @xsks_map], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_sock_prog(ptr nocapture noundef readonly %0) #0 section "xdp" !dbg !103 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata ptr %0, metadata !116, metadata !DIExpression()), !dbg !302
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2) #5, !dbg !303
  %3 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 4, !dbg !304
  %4 = load i32, ptr %3, align 4, !dbg !304, !tbaa !305
  call void @llvm.dbg.value(metadata i32 %4, metadata !117, metadata !DIExpression()), !dbg !302
  store i32 %4, ptr %2, align 4, !dbg !310, !tbaa !311
  call void @llvm.dbg.value(metadata ptr %0, metadata !187, metadata !DIExpression()), !dbg !312
  %5 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !315
  %6 = load i32, ptr %5, align 4, !dbg !315, !tbaa !316
  %7 = zext i32 %6 to i64, !dbg !317
  %8 = inttoptr i64 %7 to ptr, !dbg !318
  call void @llvm.dbg.value(metadata ptr %8, metadata !188, metadata !DIExpression()), !dbg !312
  %9 = load i32, ptr %0, align 4, !dbg !319, !tbaa !320
  %10 = zext i32 %9 to i64, !dbg !321
  %11 = inttoptr i64 %10 to ptr, !dbg !322
  call void @llvm.dbg.value(metadata ptr %11, metadata !189, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata ptr %11, metadata !256, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata ptr undef, metadata !323, metadata !DIExpression()), !dbg !332
  call void @llvm.dbg.value(metadata ptr %8, metadata !330, metadata !DIExpression()), !dbg !332
  call void @llvm.dbg.value(metadata ptr undef, metadata !331, metadata !DIExpression()), !dbg !332
  call void @llvm.dbg.value(metadata ptr undef, metadata !334, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata ptr %8, metadata !344, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata ptr undef, metadata !345, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata ptr null, metadata !346, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata ptr %11, metadata !347, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i32 14, metadata !348, metadata !DIExpression()), !dbg !357
  %12 = getelementptr i8, ptr %11, i64 14, !dbg !359
  %13 = icmp ugt ptr %12, %8, !dbg !361
  br i1 %13, label %92, label %14, !dbg !362

14:                                               ; preds = %1
  call void @llvm.dbg.value(metadata ptr %12, metadata !256, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata ptr %12, metadata !349, metadata !DIExpression()), !dbg !357
  %15 = getelementptr inbounds %struct.ethhdr, ptr %11, i64 0, i32 2, !dbg !363
  call void @llvm.dbg.value(metadata i16 poison, metadata !355, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i32 0, metadata !356, metadata !DIExpression()), !dbg !357
  %16 = load i16, ptr %15, align 1, !dbg !357, !tbaa !364
  call void @llvm.dbg.value(metadata i16 %16, metadata !355, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i16 %16, metadata !366, metadata !DIExpression()), !dbg !371
  %17 = icmp eq i16 %16, 129, !dbg !377
  %18 = icmp eq i16 %16, -22392, !dbg !378
  %19 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %17)
  %20 = or i1 %18, %19, !dbg !378
  %21 = getelementptr i8, ptr %11, i64 18
  %22 = icmp ule ptr %21, %8
  %23 = select i1 %20, i1 %22, i1 false, !dbg !379
  br i1 %23, label %24, label %37, !dbg !379

24:                                               ; preds = %14
  call void @llvm.dbg.value(metadata i16 poison, metadata !355, metadata !DIExpression()), !dbg !357
  %25 = getelementptr i8, ptr %11, i64 16, !dbg !380
  call void @llvm.dbg.value(metadata ptr %21, metadata !349, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i32 1, metadata !356, metadata !DIExpression()), !dbg !357
  %26 = load i16, ptr %25, align 1, !dbg !357, !tbaa !364
  call void @llvm.dbg.value(metadata i16 %26, metadata !355, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i16 %26, metadata !366, metadata !DIExpression()), !dbg !371
  %27 = icmp eq i16 %26, 129, !dbg !377
  %28 = icmp eq i16 %26, -22392, !dbg !378
  %29 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %27)
  %30 = or i1 %28, %29, !dbg !378
  %31 = getelementptr i8, ptr %11, i64 22
  %32 = icmp ule ptr %31, %8
  %33 = select i1 %30, i1 %32, i1 false, !dbg !379
  br i1 %33, label %34, label %37, !dbg !379

34:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i16 poison, metadata !355, metadata !DIExpression()), !dbg !357
  %35 = getelementptr i8, ptr %11, i64 20, !dbg !380
  call void @llvm.dbg.value(metadata ptr %31, metadata !349, metadata !DIExpression()), !dbg !357
  call void @llvm.dbg.value(metadata i32 2, metadata !356, metadata !DIExpression()), !dbg !357
  %36 = load i16, ptr %35, align 1, !dbg !357, !tbaa !364
  call void @llvm.dbg.value(metadata i16 %36, metadata !355, metadata !DIExpression()), !dbg !357
  br label %37

37:                                               ; preds = %34, %24, %14
  %38 = phi ptr [ %12, %14 ], [ %21, %24 ], [ %31, %34 ], !dbg !357
  %39 = phi i16 [ %16, %14 ], [ %26, %24 ], [ %36, %34 ], !dbg !357
  call void @llvm.dbg.value(metadata ptr %38, metadata !256, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata i16 %39, metadata !261, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !312
  %40 = icmp ne i16 %39, 8, !dbg !381
  %41 = getelementptr inbounds %struct.iphdr, ptr %38, i64 1
  %42 = icmp ugt ptr %41, %8
  %43 = select i1 %40, i1 true, i1 %42, !dbg !383
  call void @llvm.dbg.value(metadata ptr undef, metadata !384, metadata !DIExpression()), !dbg !394
  call void @llvm.dbg.value(metadata ptr %8, metadata !390, metadata !DIExpression()), !dbg !394
  call void @llvm.dbg.value(metadata ptr undef, metadata !391, metadata !DIExpression()), !dbg !394
  call void @llvm.dbg.value(metadata ptr %38, metadata !392, metadata !DIExpression()), !dbg !394
  br i1 %43, label %92, label %44, !dbg !383

44:                                               ; preds = %37
  %45 = load i8, ptr %38, align 4, !dbg !396
  %46 = shl i8 %45, 2, !dbg !397
  %47 = and i8 %46, 60, !dbg !397
  call void @llvm.dbg.value(metadata i8 %47, metadata !393, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !394
  %48 = icmp ult i8 %47, 20, !dbg !398
  br i1 %48, label %92, label %49, !dbg !400

49:                                               ; preds = %44
  %50 = zext i8 %47 to i64
  call void @llvm.dbg.value(metadata i64 %50, metadata !393, metadata !DIExpression()), !dbg !394
  %51 = getelementptr i8, ptr %38, i64 %50, !dbg !401
  %52 = icmp ugt ptr %51, %8, !dbg !403
  br i1 %52, label %92, label %53, !dbg !404

53:                                               ; preds = %49
  call void @llvm.dbg.value(metadata ptr %51, metadata !256, metadata !DIExpression()), !dbg !312
  %54 = getelementptr inbounds %struct.iphdr, ptr %38, i64 0, i32 6, !dbg !405
  %55 = load i8, ptr %54, align 1, !dbg !405, !tbaa !406
  call void @llvm.dbg.value(metadata i8 %55, metadata !262, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !312
  %56 = icmp ne i8 %55, 6, !dbg !408
  %57 = getelementptr inbounds %struct.tcphdr, ptr %51, i64 1
  %58 = icmp ugt ptr %57, %8
  %59 = select i1 %56, i1 true, i1 %58, !dbg !410
  call void @llvm.dbg.value(metadata ptr poison, metadata !204, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !265, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !263, metadata !DIExpression(DW_OP_constu, 255, DW_OP_and, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 0, 8)), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !263, metadata !DIExpression(DW_OP_constu, 8, DW_OP_shr, DW_OP_constu, 255, DW_OP_and, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 8, 8)), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !263, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shr, DW_OP_constu, 255, DW_OP_and, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 16, 8)), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !263, metadata !DIExpression(DW_OP_constu, 24, DW_OP_shr, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 24, 8)), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !267, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !266, metadata !DIExpression(DW_OP_constu, 255, DW_OP_and, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 0, 8)), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !266, metadata !DIExpression(DW_OP_constu, 8, DW_OP_shr, DW_OP_constu, 255, DW_OP_and, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 8, 8)), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !266, metadata !DIExpression(DW_OP_constu, 16, DW_OP_shr, DW_OP_constu, 255, DW_OP_and, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 16, 8)), !dbg !312
  call void @llvm.dbg.value(metadata i32 poison, metadata !266, metadata !DIExpression(DW_OP_constu, 24, DW_OP_shr, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 24, 8)), !dbg !312
  call void @llvm.dbg.value(metadata ptr undef, metadata !411, metadata !DIExpression()), !dbg !421
  call void @llvm.dbg.value(metadata ptr %8, metadata !417, metadata !DIExpression()), !dbg !421
  call void @llvm.dbg.value(metadata ptr undef, metadata !418, metadata !DIExpression()), !dbg !421
  call void @llvm.dbg.value(metadata ptr %51, metadata !420, metadata !DIExpression()), !dbg !421
  br i1 %59, label %92, label %60, !dbg !410

60:                                               ; preds = %53
  %61 = getelementptr inbounds %struct.tcphdr, ptr %51, i64 0, i32 4, !dbg !424
  %62 = load i16, ptr %61, align 4, !dbg !424
  %63 = lshr i16 %62, 2, !dbg !425
  %64 = and i16 %63, 60, !dbg !425
  call void @llvm.dbg.value(metadata i16 %64, metadata !419, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !421
  %65 = icmp ult i16 %64, 20, !dbg !426
  br i1 %65, label %92, label %66, !dbg !428

66:                                               ; preds = %60
  %67 = zext i16 %64 to i64
  %68 = getelementptr i8, ptr %51, i64 %67, !dbg !429
  %69 = icmp ugt ptr %68, %8, !dbg !431
  br i1 %69, label %92, label %70, !dbg !432

70:                                               ; preds = %66
  call void @llvm.dbg.value(metadata ptr %68, metadata !256, metadata !DIExpression()), !dbg !312
  call void @llvm.dbg.value(metadata ptr %51, metadata !234, metadata !DIExpression()), !dbg !312
  %71 = getelementptr inbounds %struct.tcphdr, ptr %51, i64 0, i32 1, !dbg !433
  %72 = load i16, ptr %71, align 2, !dbg !433, !tbaa !435
  %73 = tail call i16 @llvm.bswap.i16(i16 %72), !dbg !433
  %74 = zext i16 %73 to i32, !dbg !433
  %75 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @parse_packet.____fmt, i32 noundef 24, i32 noundef %74) #5, !dbg !433
  %76 = load i16, ptr %71, align 2, !dbg !437, !tbaa !435
  %77 = tail call i16 @llvm.bswap.i16(i16 %76), !dbg !437
  %78 = add i16 %77, -1, !dbg !437
  %79 = tail call i16 @llvm.bswap.i16(i16 %78), !dbg !437
  call void @llvm.dbg.value(metadata ptr %51, metadata !234, metadata !DIExpression()), !dbg !312
  store i16 %79, ptr %71, align 2, !dbg !438, !tbaa !435
  %80 = zext i16 %78 to i32, !dbg !439
  %81 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @parse_packet.____fmt.1, i32 noundef 24, i32 noundef %80) #5, !dbg !439
  %82 = tail call i32 inttoptr (i64 8 to ptr)() #5, !dbg !441
  call void @llvm.dbg.value(metadata i32 %82, metadata !118, metadata !DIExpression()), !dbg !302
  call void @llvm.dbg.value(metadata ptr %2, metadata !117, metadata !DIExpression(DW_OP_deref)), !dbg !302
  %83 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @xsks_map, ptr noundef nonnull %2) #5, !dbg !442
  %84 = icmp eq ptr %83, null, !dbg !442
  br i1 %84, label %92, label %85, !dbg !444

85:                                               ; preds = %70
  %86 = load i32, ptr %2, align 4, !dbg !445, !tbaa !311
  call void @llvm.dbg.value(metadata i32 %86, metadata !117, metadata !DIExpression()), !dbg !302
  %87 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @xdp_sock_prog.____fmt, i32 noundef 11, i32 noundef %82, i32 noundef %86) #5, !dbg !445
  %88 = load i32, ptr %2, align 4, !dbg !448, !tbaa !311
  call void @llvm.dbg.value(metadata i32 %88, metadata !117, metadata !DIExpression()), !dbg !302
  %89 = sext i32 %88 to i64, !dbg !448
  %90 = call i64 inttoptr (i64 51 to ptr)(ptr noundef nonnull @xsks_map, i64 noundef %89, i64 noundef 0) #5, !dbg !449
  %91 = trunc i64 %90 to i32, !dbg !449
  br label %92, !dbg !450

92:                                               ; preds = %66, %60, %49, %44, %1, %53, %37, %85, %70
  %93 = phi i32 [ %91, %85 ], [ 2, %70 ], [ 1, %37 ], [ 1, %53 ], [ 1, %1 ], [ 1, %44 ], [ 1, %49 ], [ 1, %60 ], [ 1, %66 ], !dbg !302
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2) #5, !dbg !451
  ret i32 %93, !dbg !451
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.bswap.i16(i16) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

; Function Attrs: nounwind memory(none)
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #4

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind memory(none) }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!297, !298, !299, !300}
!llvm.ident = !{!301}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "inner_app_array0", scope: !2, file: !3, line: 33, type: !76, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !45, globals: !51, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kernel_xdp.c", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "33c43a3a751d8f8f30dbe2472ceb58a7")
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
!51 = !{!52, !101, !124, !129, !0, !145, !147, !149, !151, !153, !155, !157, !159, !161, !163, !165, !167, !169, !171, !173, !175, !177, !179, !181, !183, !271, !273, !279, !286, !292}
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(name: "outer_app_hash", scope: !2, file: !3, line: 44, type: !54, isLocal: false, isDefinition: true)
!54 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_app_hash", file: !3, line: 39, size: 192, elements: !55)
!55 = !{!56, !62, !68, !73}
!56 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !54, file: !3, line: 40, baseType: !57, size: 64)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 416, elements: !60)
!59 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!60 = !{!61}
!61 = !DISubrange(count: 13)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !54, file: !3, line: 41, baseType: !63, size: 64, offset: 64)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash_key", file: !65, line: 15, size: 32, elements: !66)
!65 = !DIFile(filename: "./common_def.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "593d077cd9904e93e49c5c9fc7adc875")
!66 = !{!67}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "cpu", scope: !64, file: !65, line: 16, baseType: !59, size: 32)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !54, file: !3, line: 42, baseType: !69, size: 64, offset: 128)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 640, elements: !71)
!71 = !{!72}
!72 = !DISubrange(count: 20)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !54, file: !3, line: 43, baseType: !74, offset: 192)
!74 = !DICompositeType(tag: DW_TAG_array_type, baseType: !75, elements: !99)
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_app_array", file: !3, line: 28, size: 256, elements: !77)
!77 = !{!78, !83, !86, !94}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !76, file: !3, line: 29, baseType: !79, size: 64)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 64, elements: !81)
!81 = !{!82}
!82 = !DISubrange(count: 2)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !76, file: !3, line: 30, baseType: !84, size: 64, offset: 64)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !49, line: 27, baseType: !7)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !76, file: !3, line: 31, baseType: !87, size: 64, offset: 128)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!88 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "app_event", file: !65, line: 19, size: 128, elements: !89)
!89 = !{!90, !93}
!90 = !DIDerivedType(tag: DW_TAG_member, name: "occupied", scope: !88, file: !65, line: 20, baseType: !91, size: 64)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !49, line: 31, baseType: !92)
!92 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !88, file: !65, line: 21, baseType: !91, size: 64, offset: 64)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !76, file: !3, line: 32, baseType: !95, size: 64, offset: 192)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !96, size: 64)
!96 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 3200, elements: !97)
!97 = !{!98}
!98 = !DISubrange(count: 100)
!99 = !{!100}
!100 = !DISubrange(count: -1)
!101 = !DIGlobalVariableExpression(var: !102, expr: !DIExpression())
!102 = distinct !DIGlobalVariable(name: "____fmt", scope: !103, file: !3, line: 146, type: !119, isLocal: true, isDefinition: true)
!103 = distinct !DISubprogram(name: "xdp_sock_prog", scope: !3, file: !3, line: 134, type: !104, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !115)
!104 = !DISubroutineType(types: !105)
!105 = !{!59, !106}
!106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !107, size: 64)
!107 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5447, size: 192, elements: !108)
!108 = !{!109, !110, !111, !112, !113, !114}
!109 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !107, file: !6, line: 5448, baseType: !85, size: 32)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !107, file: !6, line: 5449, baseType: !85, size: 32, offset: 32)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !107, file: !6, line: 5450, baseType: !85, size: 32, offset: 64)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !107, file: !6, line: 5452, baseType: !85, size: 32, offset: 96)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !107, file: !6, line: 5453, baseType: !85, size: 32, offset: 128)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !107, file: !6, line: 5455, baseType: !85, size: 32, offset: 160)
!115 = !{!116, !117, !118}
!116 = !DILocalVariable(name: "ctx", arg: 1, scope: !103, file: !3, line: 134, type: !106)
!117 = !DILocalVariable(name: "index", scope: !103, file: !3, line: 136, type: !59)
!118 = !DILocalVariable(name: "cpu", scope: !103, file: !3, line: 143, type: !59)
!119 = !DICompositeType(tag: DW_TAG_array_type, baseType: !120, size: 88, elements: !122)
!120 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !121)
!121 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!122 = !{!123}
!123 = !DISubrange(count: 11)
!124 = !DIGlobalVariableExpression(var: !125, expr: !DIExpression())
!125 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 153, type: !126, isLocal: false, isDefinition: true)
!126 = !DICompositeType(tag: DW_TAG_array_type, baseType: !121, size: 32, elements: !127)
!127 = !{!128}
!128 = !DISubrange(count: 4)
!129 = !DIGlobalVariableExpression(var: !130, expr: !DIExpression())
!130 = distinct !DIGlobalVariable(name: "xsks_map", scope: !2, file: !3, line: 26, type: !131, isLocal: false, isDefinition: true)
!131 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 21, size: 256, elements: !132)
!132 = !{!133, !138, !139, !140}
!133 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !131, file: !3, line: 22, baseType: !134, size: 64)
!134 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !135, size: 64)
!135 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 544, elements: !136)
!136 = !{!137}
!137 = !DISubrange(count: 17)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !131, file: !3, line: 23, baseType: !84, size: 64, offset: 64)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !131, file: !3, line: 24, baseType: !84, size: 64, offset: 128)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !131, file: !3, line: 25, baseType: !141, size: 64, offset: 192)
!141 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !142, size: 64)
!142 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 256, elements: !143)
!143 = !{!144}
!144 = !DISubrange(count: 8)
!145 = !DIGlobalVariableExpression(var: !146, expr: !DIExpression())
!146 = distinct !DIGlobalVariable(name: "inner_app_array1", scope: !2, file: !3, line: 33, type: !76, isLocal: false, isDefinition: true)
!147 = !DIGlobalVariableExpression(var: !148, expr: !DIExpression())
!148 = distinct !DIGlobalVariable(name: "inner_app_array2", scope: !2, file: !3, line: 33, type: !76, isLocal: false, isDefinition: true)
!149 = !DIGlobalVariableExpression(var: !150, expr: !DIExpression())
!150 = distinct !DIGlobalVariable(name: "inner_app_array3", scope: !2, file: !3, line: 33, type: !76, isLocal: false, isDefinition: true)
!151 = !DIGlobalVariableExpression(var: !152, expr: !DIExpression())
!152 = distinct !DIGlobalVariable(name: "inner_app_array4", scope: !2, file: !3, line: 34, type: !76, isLocal: false, isDefinition: true)
!153 = !DIGlobalVariableExpression(var: !154, expr: !DIExpression())
!154 = distinct !DIGlobalVariable(name: "inner_app_array5", scope: !2, file: !3, line: 34, type: !76, isLocal: false, isDefinition: true)
!155 = !DIGlobalVariableExpression(var: !156, expr: !DIExpression())
!156 = distinct !DIGlobalVariable(name: "inner_app_array6", scope: !2, file: !3, line: 34, type: !76, isLocal: false, isDefinition: true)
!157 = !DIGlobalVariableExpression(var: !158, expr: !DIExpression())
!158 = distinct !DIGlobalVariable(name: "inner_app_array7", scope: !2, file: !3, line: 34, type: !76, isLocal: false, isDefinition: true)
!159 = !DIGlobalVariableExpression(var: !160, expr: !DIExpression())
!160 = distinct !DIGlobalVariable(name: "inner_app_array8", scope: !2, file: !3, line: 35, type: !76, isLocal: false, isDefinition: true)
!161 = !DIGlobalVariableExpression(var: !162, expr: !DIExpression())
!162 = distinct !DIGlobalVariable(name: "inner_app_array9", scope: !2, file: !3, line: 35, type: !76, isLocal: false, isDefinition: true)
!163 = !DIGlobalVariableExpression(var: !164, expr: !DIExpression())
!164 = distinct !DIGlobalVariable(name: "inner_app_array10", scope: !2, file: !3, line: 35, type: !76, isLocal: false, isDefinition: true)
!165 = !DIGlobalVariableExpression(var: !166, expr: !DIExpression())
!166 = distinct !DIGlobalVariable(name: "inner_app_array11", scope: !2, file: !3, line: 35, type: !76, isLocal: false, isDefinition: true)
!167 = !DIGlobalVariableExpression(var: !168, expr: !DIExpression())
!168 = distinct !DIGlobalVariable(name: "inner_app_array12", scope: !2, file: !3, line: 36, type: !76, isLocal: false, isDefinition: true)
!169 = !DIGlobalVariableExpression(var: !170, expr: !DIExpression())
!170 = distinct !DIGlobalVariable(name: "inner_app_array13", scope: !2, file: !3, line: 36, type: !76, isLocal: false, isDefinition: true)
!171 = !DIGlobalVariableExpression(var: !172, expr: !DIExpression())
!172 = distinct !DIGlobalVariable(name: "inner_app_array14", scope: !2, file: !3, line: 36, type: !76, isLocal: false, isDefinition: true)
!173 = !DIGlobalVariableExpression(var: !174, expr: !DIExpression())
!174 = distinct !DIGlobalVariable(name: "inner_app_array15", scope: !2, file: !3, line: 36, type: !76, isLocal: false, isDefinition: true)
!175 = !DIGlobalVariableExpression(var: !176, expr: !DIExpression())
!176 = distinct !DIGlobalVariable(name: "inner_app_array16", scope: !2, file: !3, line: 37, type: !76, isLocal: false, isDefinition: true)
!177 = !DIGlobalVariableExpression(var: !178, expr: !DIExpression())
!178 = distinct !DIGlobalVariable(name: "inner_app_array17", scope: !2, file: !3, line: 37, type: !76, isLocal: false, isDefinition: true)
!179 = !DIGlobalVariableExpression(var: !180, expr: !DIExpression())
!180 = distinct !DIGlobalVariable(name: "inner_app_array18", scope: !2, file: !3, line: 37, type: !76, isLocal: false, isDefinition: true)
!181 = !DIGlobalVariableExpression(var: !182, expr: !DIExpression())
!182 = distinct !DIGlobalVariable(name: "inner_app_array19", scope: !2, file: !3, line: 37, type: !76, isLocal: false, isDefinition: true)
!183 = !DIGlobalVariableExpression(var: !184, expr: !DIExpression())
!184 = distinct !DIGlobalVariable(name: "____fmt", scope: !185, file: !3, line: 124, type: !268, isLocal: true, isDefinition: true)
!185 = distinct !DISubprogram(name: "parse_packet", scope: !3, file: !3, line: 54, type: !104, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !186)
!186 = !{!187, !188, !189, !190, !204, !234, !256, !261, !262, !263, !265, !266, !267}
!187 = !DILocalVariable(name: "ctx", arg: 1, scope: !185, file: !3, line: 54, type: !106)
!188 = !DILocalVariable(name: "data_end", scope: !185, file: !3, line: 55, type: !46)
!189 = !DILocalVariable(name: "data", scope: !185, file: !3, line: 56, type: !46)
!190 = !DILocalVariable(name: "eth", scope: !185, file: !3, line: 60, type: !191)
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !193, line: 168, size: 112, elements: !194)
!193 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!194 = !{!195, !200, !201}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !192, file: !193, line: 169, baseType: !196, size: 48)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 48, elements: !198)
!197 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!198 = !{!199}
!199 = !DISubrange(count: 6)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !192, file: !193, line: 170, baseType: !196, size: 48, offset: 48)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !192, file: !193, line: 171, baseType: !202, size: 16, offset: 96)
!202 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !203, line: 25, baseType: !48)
!203 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!204 = !DILocalVariable(name: "iphdr", scope: !185, file: !3, line: 61, type: !205)
!205 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !206, size: 64)
!206 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !207, line: 87, size: 160, elements: !208)
!207 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "042b09a58768855e3578a0a8eba49be7")
!208 = !{!209, !211, !212, !213, !214, !215, !216, !217, !218, !220}
!209 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !206, file: !207, line: 89, baseType: !210, size: 4, flags: DIFlagBitField, extraData: i64 0)
!210 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !49, line: 21, baseType: !197)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !206, file: !207, line: 90, baseType: !210, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !206, file: !207, line: 97, baseType: !210, size: 8, offset: 8)
!213 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !206, file: !207, line: 98, baseType: !202, size: 16, offset: 16)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !206, file: !207, line: 99, baseType: !202, size: 16, offset: 32)
!215 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !206, file: !207, line: 100, baseType: !202, size: 16, offset: 48)
!216 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !206, file: !207, line: 101, baseType: !210, size: 8, offset: 64)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !206, file: !207, line: 102, baseType: !210, size: 8, offset: 72)
!218 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !206, file: !207, line: 103, baseType: !219, size: 16, offset: 80)
!219 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !203, line: 31, baseType: !48)
!220 = !DIDerivedType(tag: DW_TAG_member, scope: !206, file: !207, line: 104, baseType: !221, size: 64, offset: 96)
!221 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !206, file: !207, line: 104, size: 64, elements: !222)
!222 = !{!223, !229}
!223 = !DIDerivedType(tag: DW_TAG_member, scope: !221, file: !207, line: 104, baseType: !224, size: 64)
!224 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !221, file: !207, line: 104, size: 64, elements: !225)
!225 = !{!226, !228}
!226 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !224, file: !207, line: 104, baseType: !227, size: 32)
!227 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !203, line: 27, baseType: !85)
!228 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !224, file: !207, line: 104, baseType: !227, size: 32, offset: 32)
!229 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !221, file: !207, line: 104, baseType: !230, size: 64)
!230 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !221, file: !207, line: 104, size: 64, elements: !231)
!231 = !{!232, !233}
!232 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !230, file: !207, line: 104, baseType: !227, size: 32)
!233 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !230, file: !207, line: 104, baseType: !227, size: 32, offset: 32)
!234 = !DILocalVariable(name: "tcph", scope: !185, file: !3, line: 62, type: !235)
!235 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !236, size: 64)
!236 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !237, line: 25, size: 160, elements: !238)
!237 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "", checksumkind: CSK_MD5, checksum: "8d74bf2133e7b3dab885994b9916aa13")
!238 = !{!239, !240, !241, !242, !243, !244, !245, !246, !247, !248, !249, !250, !251, !252, !253, !254, !255}
!239 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !236, file: !237, line: 26, baseType: !202, size: 16)
!240 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !236, file: !237, line: 27, baseType: !202, size: 16, offset: 16)
!241 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !236, file: !237, line: 28, baseType: !227, size: 32, offset: 32)
!242 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !236, file: !237, line: 29, baseType: !227, size: 32, offset: 64)
!243 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !236, file: !237, line: 31, baseType: !48, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!244 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !236, file: !237, line: 32, baseType: !48, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!245 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !236, file: !237, line: 33, baseType: !48, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!246 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !236, file: !237, line: 34, baseType: !48, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!247 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !236, file: !237, line: 35, baseType: !48, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!248 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !236, file: !237, line: 36, baseType: !48, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!249 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !236, file: !237, line: 37, baseType: !48, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!250 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !236, file: !237, line: 38, baseType: !48, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!251 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !236, file: !237, line: 39, baseType: !48, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!252 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !236, file: !237, line: 40, baseType: !48, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!253 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !236, file: !237, line: 55, baseType: !202, size: 16, offset: 112)
!254 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !236, file: !237, line: 56, baseType: !219, size: 16, offset: 128)
!255 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !236, file: !237, line: 57, baseType: !202, size: 16, offset: 144)
!256 = !DILocalVariable(name: "nh", scope: !185, file: !3, line: 64, type: !257)
!257 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !258, line: 33, size: 64, elements: !259)
!258 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "172efdd203783aed49c0ce78645261a8")
!259 = !{!260}
!260 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !257, file: !258, line: 34, baseType: !46, size: 64)
!261 = !DILocalVariable(name: "eth_type", scope: !185, file: !3, line: 65, type: !59)
!262 = !DILocalVariable(name: "ip_type", scope: !185, file: !3, line: 65, type: !59)
!263 = !DILocalVariable(name: "src_ip", scope: !185, file: !3, line: 96, type: !264)
!264 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 32, elements: !127)
!265 = !DILocalVariable(name: "saddr", scope: !185, file: !3, line: 98, type: !227)
!266 = !DILocalVariable(name: "dst_ip", scope: !185, file: !3, line: 105, type: !264)
!267 = !DILocalVariable(name: "daddr", scope: !185, file: !3, line: 107, type: !227)
!268 = !DICompositeType(tag: DW_TAG_array_type, baseType: !120, size: 192, elements: !269)
!269 = !{!270}
!270 = !DISubrange(count: 24)
!271 = !DIGlobalVariableExpression(var: !272, expr: !DIExpression())
!272 = distinct !DIGlobalVariable(name: "____fmt", scope: !185, file: !3, line: 128, type: !268, isLocal: true, isDefinition: true)
!273 = !DIGlobalVariableExpression(var: !274, expr: !DIExpression())
!274 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !275, line: 206, type: !276, isLocal: true, isDefinition: true)
!275 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!276 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !277, size: 64)
!277 = !DISubroutineType(types: !278)
!278 = !{!85}
!279 = !DIGlobalVariableExpression(var: !280, expr: !DIExpression())
!280 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !275, line: 56, type: !281, isLocal: true, isDefinition: true)
!281 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !282, size: 64)
!282 = !DISubroutineType(types: !283)
!283 = !{!46, !46, !284}
!284 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !285, size: 64)
!285 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!286 = !DIGlobalVariableExpression(var: !287, expr: !DIExpression())
!287 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !275, line: 177, type: !288, isLocal: true, isDefinition: true)
!288 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !289, size: 64)
!289 = !DISubroutineType(types: !290)
!290 = !{!47, !291, !85, null}
!291 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!292 = !DIGlobalVariableExpression(var: !293, expr: !DIExpression())
!293 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !275, line: 1323, type: !294, isLocal: true, isDefinition: true)
!294 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !295, size: 64)
!295 = !DISubroutineType(types: !296)
!296 = !{!47, !46, !91, !91}
!297 = !{i32 7, !"Dwarf Version", i32 5}
!298 = !{i32 2, !"Debug Info Version", i32 3}
!299 = !{i32 1, !"wchar_size", i32 4}
!300 = !{i32 7, !"frame-pointer", i32 2}
!301 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!302 = !DILocation(line: 0, scope: !103)
!303 = !DILocation(line: 136, column: 5, scope: !103)
!304 = !DILocation(line: 136, column: 22, scope: !103)
!305 = !{!306, !307, i64 16}
!306 = !{!"xdp_md", !307, i64 0, !307, i64 4, !307, i64 8, !307, i64 12, !307, i64 16, !307, i64 20}
!307 = !{!"int", !308, i64 0}
!308 = !{!"omnipotent char", !309, i64 0}
!309 = !{!"Simple C/C++ TBAA"}
!310 = !DILocation(line: 136, column: 9, scope: !103)
!311 = !{!307, !307, i64 0}
!312 = !DILocation(line: 0, scope: !185, inlinedAt: !313)
!313 = distinct !DILocation(line: 138, column: 9, scope: !314)
!314 = distinct !DILexicalBlock(scope: !103, file: !3, line: 138, column: 8)
!315 = !DILocation(line: 55, column: 41, scope: !185, inlinedAt: !313)
!316 = !{!306, !307, i64 4}
!317 = !DILocation(line: 55, column: 30, scope: !185, inlinedAt: !313)
!318 = !DILocation(line: 55, column: 22, scope: !185, inlinedAt: !313)
!319 = !DILocation(line: 56, column: 41, scope: !185, inlinedAt: !313)
!320 = !{!306, !307, i64 0}
!321 = !DILocation(line: 56, column: 30, scope: !185, inlinedAt: !313)
!322 = !DILocation(line: 56, column: 22, scope: !185, inlinedAt: !313)
!323 = !DILocalVariable(name: "nh", arg: 1, scope: !324, file: !258, line: 124, type: !327)
!324 = distinct !DISubprogram(name: "parse_ethhdr", scope: !258, file: !258, line: 124, type: !325, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !329)
!325 = !DISubroutineType(types: !326)
!326 = !{!59, !327, !46, !328}
!327 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!328 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !191, size: 64)
!329 = !{!323, !330, !331}
!330 = !DILocalVariable(name: "data_end", arg: 2, scope: !324, file: !258, line: 125, type: !46)
!331 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !324, file: !258, line: 126, type: !328)
!332 = !DILocation(line: 0, scope: !324, inlinedAt: !333)
!333 = distinct !DILocation(line: 69, column: 16, scope: !185, inlinedAt: !313)
!334 = !DILocalVariable(name: "nh", arg: 1, scope: !335, file: !258, line: 79, type: !327)
!335 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !258, file: !258, line: 79, type: !336, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !343)
!336 = !DISubroutineType(types: !337)
!337 = !{!59, !327, !46, !328, !338}
!338 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !339, size: 64)
!339 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !258, line: 64, size: 32, elements: !340)
!340 = !{!341}
!341 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !339, file: !258, line: 65, baseType: !342, size: 32)
!342 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 32, elements: !81)
!343 = !{!334, !344, !345, !346, !347, !348, !349, !355, !356}
!344 = !DILocalVariable(name: "data_end", arg: 2, scope: !335, file: !258, line: 80, type: !46)
!345 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !335, file: !258, line: 81, type: !328)
!346 = !DILocalVariable(name: "vlans", arg: 4, scope: !335, file: !258, line: 82, type: !338)
!347 = !DILocalVariable(name: "eth", scope: !335, file: !258, line: 84, type: !191)
!348 = !DILocalVariable(name: "hdrsize", scope: !335, file: !258, line: 85, type: !59)
!349 = !DILocalVariable(name: "vlh", scope: !335, file: !258, line: 86, type: !350)
!350 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !351, size: 64)
!351 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !258, line: 42, size: 32, elements: !352)
!352 = !{!353, !354}
!353 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !351, file: !258, line: 43, baseType: !202, size: 16)
!354 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !351, file: !258, line: 44, baseType: !202, size: 16, offset: 16)
!355 = !DILocalVariable(name: "h_proto", scope: !335, file: !258, line: 87, type: !48)
!356 = !DILocalVariable(name: "i", scope: !335, file: !258, line: 88, type: !59)
!357 = !DILocation(line: 0, scope: !335, inlinedAt: !358)
!358 = distinct !DILocation(line: 129, column: 9, scope: !324, inlinedAt: !333)
!359 = !DILocation(line: 93, column: 14, scope: !360, inlinedAt: !358)
!360 = distinct !DILexicalBlock(scope: !335, file: !258, line: 93, column: 6)
!361 = !DILocation(line: 93, column: 24, scope: !360, inlinedAt: !358)
!362 = !DILocation(line: 93, column: 6, scope: !335, inlinedAt: !358)
!363 = !DILocation(line: 99, column: 17, scope: !335, inlinedAt: !358)
!364 = !{!365, !365, i64 0}
!365 = !{!"short", !308, i64 0}
!366 = !DILocalVariable(name: "h_proto", arg: 1, scope: !367, file: !258, line: 68, type: !48)
!367 = distinct !DISubprogram(name: "proto_is_vlan", scope: !258, file: !258, line: 68, type: !368, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !370)
!368 = !DISubroutineType(types: !369)
!369 = !{!59, !48}
!370 = !{!366}
!371 = !DILocation(line: 0, scope: !367, inlinedAt: !372)
!372 = distinct !DILocation(line: 106, column: 8, scope: !373, inlinedAt: !358)
!373 = distinct !DILexicalBlock(scope: !374, file: !258, line: 106, column: 7)
!374 = distinct !DILexicalBlock(scope: !375, file: !258, line: 105, column: 39)
!375 = distinct !DILexicalBlock(scope: !376, file: !258, line: 105, column: 2)
!376 = distinct !DILexicalBlock(scope: !335, file: !258, line: 105, column: 2)
!377 = !DILocation(line: 70, column: 20, scope: !367, inlinedAt: !372)
!378 = !DILocation(line: 70, column: 46, scope: !367, inlinedAt: !372)
!379 = !DILocation(line: 106, column: 7, scope: !374, inlinedAt: !358)
!380 = !DILocation(line: 112, column: 18, scope: !374, inlinedAt: !358)
!381 = !DILocation(line: 70, column: 18, scope: !382, inlinedAt: !313)
!382 = distinct !DILexicalBlock(scope: !185, file: !3, line: 70, column: 9)
!383 = !DILocation(line: 70, column: 9, scope: !185, inlinedAt: !313)
!384 = !DILocalVariable(name: "nh", arg: 1, scope: !385, file: !258, line: 151, type: !327)
!385 = distinct !DISubprogram(name: "parse_iphdr", scope: !258, file: !258, line: 151, type: !386, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !389)
!386 = !DISubroutineType(types: !387)
!387 = !{!59, !327, !46, !388}
!388 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !205, size: 64)
!389 = !{!384, !390, !391, !392, !393}
!390 = !DILocalVariable(name: "data_end", arg: 2, scope: !385, file: !258, line: 152, type: !46)
!391 = !DILocalVariable(name: "iphdr", arg: 3, scope: !385, file: !258, line: 153, type: !388)
!392 = !DILocalVariable(name: "iph", scope: !385, file: !258, line: 155, type: !205)
!393 = !DILocalVariable(name: "hdrsize", scope: !385, file: !258, line: 156, type: !59)
!394 = !DILocation(line: 0, scope: !385, inlinedAt: !395)
!395 = distinct !DILocation(line: 87, column: 15, scope: !185, inlinedAt: !313)
!396 = !DILocation(line: 161, column: 17, scope: !385, inlinedAt: !395)
!397 = !DILocation(line: 161, column: 21, scope: !385, inlinedAt: !395)
!398 = !DILocation(line: 163, column: 13, scope: !399, inlinedAt: !395)
!399 = distinct !DILexicalBlock(scope: !385, file: !258, line: 163, column: 5)
!400 = !DILocation(line: 163, column: 5, scope: !385, inlinedAt: !395)
!401 = !DILocation(line: 167, column: 14, scope: !402, inlinedAt: !395)
!402 = distinct !DILexicalBlock(scope: !385, file: !258, line: 167, column: 6)
!403 = !DILocation(line: 167, column: 24, scope: !402, inlinedAt: !395)
!404 = !DILocation(line: 167, column: 6, scope: !385, inlinedAt: !395)
!405 = !DILocation(line: 173, column: 14, scope: !385, inlinedAt: !395)
!406 = !{!407, !308, i64 9}
!407 = !{!"iphdr", !308, i64 0, !308, i64 0, !308, i64 1, !365, i64 2, !365, i64 4, !365, i64 6, !308, i64 8, !308, i64 9, !365, i64 10, !308, i64 12}
!408 = !DILocation(line: 91, column: 16, scope: !409, inlinedAt: !313)
!409 = distinct !DILexicalBlock(scope: !185, file: !3, line: 91, column: 8)
!410 = !DILocation(line: 91, column: 8, scope: !185, inlinedAt: !313)
!411 = !DILocalVariable(name: "nh", arg: 1, scope: !412, file: !258, line: 247, type: !327)
!412 = distinct !DISubprogram(name: "parse_tcphdr", scope: !258, file: !258, line: 247, type: !413, scopeLine: 250, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !416)
!413 = !DISubroutineType(types: !414)
!414 = !{!59, !327, !46, !415}
!415 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !235, size: 64)
!416 = !{!411, !417, !418, !419, !420}
!417 = !DILocalVariable(name: "data_end", arg: 2, scope: !412, file: !258, line: 248, type: !46)
!418 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !412, file: !258, line: 249, type: !415)
!419 = !DILocalVariable(name: "len", scope: !412, file: !258, line: 251, type: !59)
!420 = !DILocalVariable(name: "h", scope: !412, file: !258, line: 252, type: !235)
!421 = !DILocation(line: 0, scope: !412, inlinedAt: !422)
!422 = distinct !DILocation(line: 119, column: 8, scope: !423, inlinedAt: !313)
!423 = distinct !DILexicalBlock(scope: !185, file: !3, line: 119, column: 8)
!424 = !DILocation(line: 257, column: 11, scope: !412, inlinedAt: !422)
!425 = !DILocation(line: 257, column: 16, scope: !412, inlinedAt: !422)
!426 = !DILocation(line: 259, column: 9, scope: !427, inlinedAt: !422)
!427 = distinct !DILexicalBlock(scope: !412, file: !258, line: 259, column: 5)
!428 = !DILocation(line: 259, column: 5, scope: !412, inlinedAt: !422)
!429 = !DILocation(line: 263, column: 14, scope: !430, inlinedAt: !422)
!430 = distinct !DILexicalBlock(scope: !412, file: !258, line: 263, column: 6)
!431 = !DILocation(line: 263, column: 20, scope: !430, inlinedAt: !422)
!432 = !DILocation(line: 263, column: 6, scope: !412, inlinedAt: !422)
!433 = !DILocation(line: 124, column: 5, scope: !434, inlinedAt: !313)
!434 = distinct !DILexicalBlock(scope: !185, file: !3, line: 124, column: 5)
!435 = !{!436, !365, i64 2}
!436 = !{!"tcphdr", !365, i64 0, !365, i64 2, !307, i64 4, !307, i64 8, !365, i64 12, !365, i64 12, !365, i64 13, !365, i64 13, !365, i64 13, !365, i64 13, !365, i64 13, !365, i64 13, !365, i64 13, !365, i64 13, !365, i64 14, !365, i64 16, !365, i64 18}
!437 = !DILocation(line: 125, column: 18, scope: !185, inlinedAt: !313)
!438 = !DILocation(line: 125, column: 16, scope: !185, inlinedAt: !313)
!439 = !DILocation(line: 128, column: 5, scope: !440, inlinedAt: !313)
!440 = distinct !DILexicalBlock(scope: !185, file: !3, line: 128, column: 5)
!441 = !DILocation(line: 143, column: 15, scope: !103)
!442 = !DILocation(line: 145, column: 9, scope: !443)
!443 = distinct !DILexicalBlock(scope: !103, file: !3, line: 145, column: 9)
!444 = !DILocation(line: 145, column: 9, scope: !103)
!445 = !DILocation(line: 146, column: 9, scope: !446)
!446 = distinct !DILexicalBlock(scope: !447, file: !3, line: 146, column: 9)
!447 = distinct !DILexicalBlock(scope: !443, file: !3, line: 145, column: 49)
!448 = !DILocation(line: 147, column: 44, scope: !447)
!449 = !DILocation(line: 147, column: 16, scope: !447)
!450 = !DILocation(line: 147, column: 9, scope: !447)
!451 = !DILocation(line: 151, column: 1, scope: !103)
