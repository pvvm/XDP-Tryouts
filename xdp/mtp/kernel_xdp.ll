; ModuleID = 'kernel_xdp.c'
source_filename = "kernel_xdp.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.inner_app_array = type { ptr, ptr, ptr, ptr }
%struct.inner_net_array = type { ptr, ptr, ptr, ptr }
%struct.inner_timer_array = type { ptr, ptr, ptr, ptr }
%struct.inner_flow_info_hash = type { ptr, ptr, ptr, ptr }
%struct.anon = type { ptr, ptr, ptr, ptr }
%struct.anon.0 = type { ptr, ptr, ptr, ptr }
%struct.anon.1 = type { ptr, ptr, ptr, ptr }
%struct.flow_id = type { i8, i8, i8, i8 }
%struct.queue_head_tail = type { i32, i32, i32, i32, i32, i32 }
%struct.net_event = type { %struct.flow_id, i64 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, %union.anon }
%union.anon = type { %struct.anon.2 }
%struct.anon.2 = type { i32, i32 }
%struct.tcphdr = type { i16, i16, i32, i32, i16, i16, i16, i16 }

@inner_app_array0 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !0
@inner_app_array1 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !214
@inner_app_array2 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !216
@inner_app_array3 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !218
@inner_app_array4 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !220
@inner_app_array5 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !222
@inner_app_array6 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !224
@inner_app_array7 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !226
@inner_app_array8 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !228
@inner_app_array9 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !230
@inner_app_array10 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !232
@inner_app_array11 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !234
@inner_app_array12 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !236
@inner_app_array13 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !238
@inner_app_array14 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !240
@inner_app_array15 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !242
@inner_app_array16 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !244
@inner_app_array17 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !246
@inner_app_array18 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !248
@inner_app_array19 = dso_local global %struct.inner_app_array zeroinitializer, section ".maps", align 8, !dbg !250
@outer_app_hash = dso_local global { ptr, ptr, ptr, [20 x ptr] } { ptr null, ptr null, ptr null, [20 x ptr] [ptr @inner_app_array0, ptr @inner_app_array1, ptr @inner_app_array2, ptr @inner_app_array3, ptr @inner_app_array4, ptr @inner_app_array5, ptr @inner_app_array6, ptr @inner_app_array7, ptr @inner_app_array8, ptr @inner_app_array9, ptr @inner_app_array10, ptr @inner_app_array11, ptr @inner_app_array12, ptr @inner_app_array13, ptr @inner_app_array14, ptr @inner_app_array15, ptr @inner_app_array16, ptr @inner_app_array17, ptr @inner_app_array18, ptr @inner_app_array19] }, section ".maps", align 8, !dbg !85
@inner_net_array0 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !269
@inner_net_array1 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !271
@inner_net_array2 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !273
@inner_net_array3 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !275
@inner_net_array4 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !277
@inner_net_array5 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !279
@inner_net_array6 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !281
@inner_net_array7 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !283
@inner_net_array8 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !285
@inner_net_array9 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !287
@inner_net_array10 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !289
@inner_net_array11 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !291
@inner_net_array12 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !293
@inner_net_array13 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !295
@inner_net_array14 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !297
@inner_net_array15 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !299
@inner_net_array16 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !301
@inner_net_array17 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !303
@inner_net_array18 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !305
@inner_net_array19 = dso_local global %struct.inner_net_array zeroinitializer, section ".maps", align 8, !dbg !307
@outer_net_hash = dso_local global { ptr, ptr, ptr, [20 x ptr] } { ptr null, ptr null, ptr null, [20 x ptr] [ptr @inner_net_array0, ptr @inner_net_array1, ptr @inner_net_array2, ptr @inner_net_array3, ptr @inner_net_array4, ptr @inner_net_array5, ptr @inner_net_array6, ptr @inner_net_array7, ptr @inner_net_array8, ptr @inner_net_array9, ptr @inner_net_array10, ptr @inner_net_array11, ptr @inner_net_array12, ptr @inner_net_array13, ptr @inner_net_array14, ptr @inner_net_array15, ptr @inner_net_array16, ptr @inner_net_array17, ptr @inner_net_array18, ptr @inner_net_array19] }, section ".maps", align 8, !dbg !129
@inner_timer_array0 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !309
@inner_timer_array1 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !311
@inner_timer_array2 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !313
@inner_timer_array3 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !315
@inner_timer_array4 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !317
@inner_timer_array5 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !319
@inner_timer_array6 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !321
@inner_timer_array7 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !323
@inner_timer_array8 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !325
@inner_timer_array9 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !327
@inner_timer_array10 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !329
@inner_timer_array11 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !331
@inner_timer_array12 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !333
@inner_timer_array13 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !335
@inner_timer_array14 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !337
@inner_timer_array15 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !339
@inner_timer_array16 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !341
@inner_timer_array17 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !343
@inner_timer_array18 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !345
@inner_timer_array19 = dso_local global %struct.inner_timer_array zeroinitializer, section ".maps", align 8, !dbg !347
@outer_timer_hash = dso_local global { ptr, ptr, ptr, [20 x ptr] } { ptr null, ptr null, ptr null, [20 x ptr] [ptr @inner_timer_array0, ptr @inner_timer_array1, ptr @inner_timer_array2, ptr @inner_timer_array3, ptr @inner_timer_array4, ptr @inner_timer_array5, ptr @inner_timer_array6, ptr @inner_timer_array7, ptr @inner_timer_array8, ptr @inner_timer_array9, ptr @inner_timer_array10, ptr @inner_timer_array11, ptr @inner_timer_array12, ptr @inner_timer_array13, ptr @inner_timer_array14, ptr @inner_timer_array15, ptr @inner_timer_array16, ptr @inner_timer_array17, ptr @inner_timer_array18, ptr @inner_timer_array19] }, section ".maps", align 8, !dbg !145
@inner_flow_info_hash0 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !349
@inner_flow_info_hash1 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !351
@inner_flow_info_hash2 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !353
@inner_flow_info_hash3 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !355
@inner_flow_info_hash4 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !357
@inner_flow_info_hash5 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !359
@inner_flow_info_hash6 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !361
@inner_flow_info_hash7 = dso_local global %struct.inner_flow_info_hash zeroinitializer, section ".maps", align 8, !dbg !363
@outer_flow_info_array = dso_local global { ptr, ptr, ptr, [8 x ptr] } { ptr null, ptr null, ptr null, [8 x ptr] [ptr @inner_flow_info_hash0, ptr @inner_flow_info_hash1, ptr @inner_flow_info_hash2, ptr @inner_flow_info_hash3, ptr @inner_flow_info_hash4, ptr @inner_flow_info_hash5, ptr @inner_flow_info_hash6, ptr @inner_flow_info_hash7] }, section ".maps", align 8, !dbg !161
@xsks_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !202
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !196
@head_tail_hash = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !252
@timer_array = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !365
@event_enqueue.____fmt.1 = internal constant [10 x i8] c"NET_EVENT\00", align 1, !dbg !400
@event_enqueue.____fmt.2 = internal constant [24 x i8] c"Unable to enqueue event\00", align 1, !dbg !402
@try_to_enqueue.____fmt = internal constant [39 x i8] c"Queue is full: unable to enqueue event\00", align 1, !dbg !431
@try_to_enqueue.____fmt.6 = internal constant [34 x i8] c"Couldn't get entry from outer map\00", align 1, !dbg !448
@try_to_enqueue.____fmt.7 = internal constant [37 x i8] c"Couldn't update entry from inner map\00", align 1, !dbg !453
@llvm.compiler.used = appending global [77 x ptr] [ptr @_license, ptr @head_tail_hash, ptr @inner_app_array0, ptr @inner_app_array1, ptr @inner_app_array10, ptr @inner_app_array11, ptr @inner_app_array12, ptr @inner_app_array13, ptr @inner_app_array14, ptr @inner_app_array15, ptr @inner_app_array16, ptr @inner_app_array17, ptr @inner_app_array18, ptr @inner_app_array19, ptr @inner_app_array2, ptr @inner_app_array3, ptr @inner_app_array4, ptr @inner_app_array5, ptr @inner_app_array6, ptr @inner_app_array7, ptr @inner_app_array8, ptr @inner_app_array9, ptr @inner_flow_info_hash0, ptr @inner_flow_info_hash1, ptr @inner_flow_info_hash2, ptr @inner_flow_info_hash3, ptr @inner_flow_info_hash4, ptr @inner_flow_info_hash5, ptr @inner_flow_info_hash6, ptr @inner_flow_info_hash7, ptr @inner_net_array0, ptr @inner_net_array1, ptr @inner_net_array10, ptr @inner_net_array11, ptr @inner_net_array12, ptr @inner_net_array13, ptr @inner_net_array14, ptr @inner_net_array15, ptr @inner_net_array16, ptr @inner_net_array17, ptr @inner_net_array18, ptr @inner_net_array19, ptr @inner_net_array2, ptr @inner_net_array3, ptr @inner_net_array4, ptr @inner_net_array5, ptr @inner_net_array6, ptr @inner_net_array7, ptr @inner_net_array8, ptr @inner_net_array9, ptr @inner_timer_array0, ptr @inner_timer_array1, ptr @inner_timer_array10, ptr @inner_timer_array11, ptr @inner_timer_array12, ptr @inner_timer_array13, ptr @inner_timer_array14, ptr @inner_timer_array15, ptr @inner_timer_array16, ptr @inner_timer_array17, ptr @inner_timer_array18, ptr @inner_timer_array19, ptr @inner_timer_array2, ptr @inner_timer_array3, ptr @inner_timer_array4, ptr @inner_timer_array5, ptr @inner_timer_array6, ptr @inner_timer_array7, ptr @inner_timer_array8, ptr @inner_timer_array9, ptr @outer_app_hash, ptr @outer_flow_info_array, ptr @outer_net_hash, ptr @outer_timer_hash, ptr @rx_module, ptr @timer_array, ptr @xsks_map], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @rx_module(ptr nocapture noundef readonly %0) #0 section "xdp" !dbg !473 {
  %2 = alloca %struct.flow_id, align 4
  %3 = alloca %struct.flow_id, align 4
  %4 = alloca %struct.queue_head_tail, align 4
  %5 = alloca i32, align 4
  %6 = alloca %struct.net_event, align 8
  call void @llvm.dbg.value(metadata ptr %0, metadata !486, metadata !DIExpression()), !dbg !489
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5) #6, !dbg !490
  %7 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 4, !dbg !491
  %8 = load i32, ptr %7, align 4, !dbg !491, !tbaa !492
  call void @llvm.dbg.value(metadata i32 %8, metadata !487, metadata !DIExpression()), !dbg !489
  store i32 %8, ptr %5, align 4, !dbg !497, !tbaa !498
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %6) #6, !dbg !499
  call void @llvm.dbg.declare(metadata ptr %6, metadata !488, metadata !DIExpression()), !dbg !500
  call void @llvm.dbg.value(metadata ptr %0, metadata !501, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata ptr %6, metadata !506, metadata !DIExpression()), !dbg !588
  %9 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !591
  %10 = load i32, ptr %9, align 4, !dbg !591, !tbaa !592
  %11 = zext i32 %10 to i64, !dbg !593
  %12 = inttoptr i64 %11 to ptr, !dbg !594
  call void @llvm.dbg.value(metadata ptr %12, metadata !507, metadata !DIExpression()), !dbg !588
  %13 = load i32, ptr %0, align 4, !dbg !595, !tbaa !596
  %14 = zext i32 %13 to i64, !dbg !597
  %15 = inttoptr i64 %14 to ptr, !dbg !598
  call void @llvm.dbg.value(metadata ptr %15, metadata !508, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata ptr %15, metadata !573, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata ptr undef, metadata !599, metadata !DIExpression()), !dbg !608
  call void @llvm.dbg.value(metadata ptr %12, metadata !606, metadata !DIExpression()), !dbg !608
  call void @llvm.dbg.value(metadata ptr undef, metadata !607, metadata !DIExpression()), !dbg !608
  call void @llvm.dbg.value(metadata ptr undef, metadata !610, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata ptr %12, metadata !620, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata ptr undef, metadata !621, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata ptr null, metadata !622, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata ptr %15, metadata !623, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata i32 14, metadata !624, metadata !DIExpression()), !dbg !633
  %16 = getelementptr i8, ptr %15, i64 14, !dbg !635
  %17 = icmp ugt ptr %16, %12, !dbg !637
  br i1 %17, label %155, label %18, !dbg !638

18:                                               ; preds = %1
  call void @llvm.dbg.value(metadata ptr %16, metadata !573, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata ptr %16, metadata !625, metadata !DIExpression()), !dbg !633
  %19 = getelementptr inbounds %struct.ethhdr, ptr %15, i64 0, i32 2, !dbg !639
  call void @llvm.dbg.value(metadata i16 poison, metadata !631, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata i32 0, metadata !632, metadata !DIExpression()), !dbg !633
  %20 = load i16, ptr %19, align 1, !dbg !633, !tbaa !640
  call void @llvm.dbg.value(metadata i16 %20, metadata !631, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata i16 %20, metadata !642, metadata !DIExpression()), !dbg !647
  %21 = icmp eq i16 %20, 129, !dbg !653
  %22 = icmp eq i16 %20, -22392, !dbg !654
  %23 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %21)
  %24 = or i1 %22, %23, !dbg !654
  %25 = getelementptr i8, ptr %15, i64 18
  %26 = icmp ule ptr %25, %12
  %27 = select i1 %24, i1 %26, i1 false, !dbg !655
  br i1 %27, label %28, label %41, !dbg !655

28:                                               ; preds = %18
  call void @llvm.dbg.value(metadata i16 poison, metadata !631, metadata !DIExpression()), !dbg !633
  %29 = getelementptr i8, ptr %15, i64 16, !dbg !656
  call void @llvm.dbg.value(metadata ptr %25, metadata !625, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata i32 1, metadata !632, metadata !DIExpression()), !dbg !633
  %30 = load i16, ptr %29, align 1, !dbg !633, !tbaa !640
  call void @llvm.dbg.value(metadata i16 %30, metadata !631, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata i16 %30, metadata !642, metadata !DIExpression()), !dbg !647
  %31 = icmp eq i16 %30, 129, !dbg !653
  %32 = icmp eq i16 %30, -22392, !dbg !654
  %33 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %31)
  %34 = or i1 %32, %33, !dbg !654
  %35 = getelementptr i8, ptr %15, i64 22
  %36 = icmp ule ptr %35, %12
  %37 = select i1 %34, i1 %36, i1 false, !dbg !655
  br i1 %37, label %38, label %41, !dbg !655

38:                                               ; preds = %28
  call void @llvm.dbg.value(metadata i16 poison, metadata !631, metadata !DIExpression()), !dbg !633
  %39 = getelementptr i8, ptr %15, i64 20, !dbg !656
  call void @llvm.dbg.value(metadata ptr %35, metadata !625, metadata !DIExpression()), !dbg !633
  call void @llvm.dbg.value(metadata i32 2, metadata !632, metadata !DIExpression()), !dbg !633
  %40 = load i16, ptr %39, align 1, !dbg !633, !tbaa !640
  call void @llvm.dbg.value(metadata i16 %40, metadata !631, metadata !DIExpression()), !dbg !633
  br label %41

41:                                               ; preds = %38, %28, %18
  %42 = phi ptr [ %16, %18 ], [ %25, %28 ], [ %35, %38 ], !dbg !633
  %43 = phi i16 [ %20, %18 ], [ %30, %28 ], [ %40, %38 ], !dbg !633
  call void @llvm.dbg.value(metadata ptr %42, metadata !573, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata i16 %43, metadata !578, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %44 = icmp ne i16 %43, 8, !dbg !657
  %45 = getelementptr inbounds %struct.iphdr, ptr %42, i64 1
  %46 = icmp ugt ptr %45, %12
  %47 = select i1 %44, i1 true, i1 %46, !dbg !659
  call void @llvm.dbg.value(metadata ptr undef, metadata !660, metadata !DIExpression()), !dbg !670
  call void @llvm.dbg.value(metadata ptr %12, metadata !666, metadata !DIExpression()), !dbg !670
  call void @llvm.dbg.value(metadata ptr undef, metadata !667, metadata !DIExpression()), !dbg !670
  call void @llvm.dbg.value(metadata ptr %42, metadata !668, metadata !DIExpression()), !dbg !670
  br i1 %47, label %155, label %48, !dbg !659

48:                                               ; preds = %41
  %49 = load i8, ptr %42, align 4, !dbg !672
  %50 = shl i8 %49, 2, !dbg !673
  %51 = and i8 %50, 60, !dbg !673
  call void @llvm.dbg.value(metadata i8 %51, metadata !669, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !670
  %52 = icmp ult i8 %51, 20, !dbg !674
  br i1 %52, label %155, label %53, !dbg !676

53:                                               ; preds = %48
  %54 = zext i8 %51 to i64
  call void @llvm.dbg.value(metadata i64 %54, metadata !669, metadata !DIExpression()), !dbg !670
  %55 = getelementptr i8, ptr %42, i64 %54, !dbg !677
  %56 = icmp ugt ptr %55, %12, !dbg !679
  br i1 %56, label %155, label %57, !dbg !680

57:                                               ; preds = %53
  call void @llvm.dbg.value(metadata ptr %55, metadata !573, metadata !DIExpression()), !dbg !588
  %58 = getelementptr inbounds %struct.iphdr, ptr %42, i64 0, i32 6, !dbg !681
  %59 = load i8, ptr %58, align 1, !dbg !681, !tbaa !682
  call void @llvm.dbg.value(metadata i8 %59, metadata !579, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %60 = icmp eq i8 %59, 6, !dbg !684
  br i1 %60, label %61, label %155, !dbg !686

61:                                               ; preds = %57
  call void @llvm.dbg.value(metadata ptr %42, metadata !522, metadata !DIExpression()), !dbg !588
  %62 = getelementptr inbounds %struct.iphdr, ptr %42, i64 0, i32 8, !dbg !687
  %63 = load i32, ptr %62, align 4, !dbg !687, !tbaa !688
  call void @llvm.dbg.value(metadata i32 %63, metadata !580, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata i32 %63, metadata !581, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %64 = lshr i32 %63, 8, !dbg !689
  call void @llvm.dbg.value(metadata !DIArgList(i32 %64, i32 %63), metadata !581, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %65 = lshr i32 %63, 16, !dbg !690
  call void @llvm.dbg.value(metadata !DIArgList(i32 poison, i32 poison), metadata !581, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %66 = lshr i32 %63, 24, !dbg !691
  %67 = xor i32 %64, %65, !dbg !692
  %68 = xor i32 %67, %66, !dbg !692
  %69 = xor i32 %68, %63, !dbg !692
  %70 = trunc i32 %69 to i8, !dbg !693
  call void @llvm.dbg.value(metadata i8 %70, metadata !581, metadata !DIExpression()), !dbg !588
  store i8 %70, ptr %6, align 8, !dbg !694, !tbaa !695
  %71 = getelementptr inbounds %struct.iphdr, ptr %42, i64 0, i32 8, i32 0, i32 1, !dbg !699
  %72 = load i32, ptr %71, align 4, !dbg !699, !tbaa !688
  call void @llvm.dbg.value(metadata i32 %72, metadata !582, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata i32 %72, metadata !583, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %73 = lshr i32 %72, 8, !dbg !700
  call void @llvm.dbg.value(metadata !DIArgList(i32 %73, i32 %72), metadata !583, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %74 = lshr i32 %72, 16, !dbg !701
  call void @llvm.dbg.value(metadata !DIArgList(i32 poison, i32 poison), metadata !583, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_xor, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %75 = lshr i32 %72, 24, !dbg !702
  %76 = xor i32 %73, %74, !dbg !703
  %77 = xor i32 %76, %75, !dbg !703
  %78 = xor i32 %77, %72, !dbg !703
  %79 = trunc i32 %78 to i8, !dbg !704
  call void @llvm.dbg.value(metadata i8 %79, metadata !583, metadata !DIExpression()), !dbg !588
  %80 = getelementptr inbounds %struct.flow_id, ptr %6, i64 0, i32 2, !dbg !705
  store i8 %79, ptr %80, align 2, !dbg !706, !tbaa !707
  call void @llvm.dbg.value(metadata ptr undef, metadata !708, metadata !DIExpression()), !dbg !718
  call void @llvm.dbg.value(metadata ptr %12, metadata !714, metadata !DIExpression()), !dbg !718
  call void @llvm.dbg.value(metadata ptr undef, metadata !715, metadata !DIExpression()), !dbg !718
  call void @llvm.dbg.value(metadata ptr %55, metadata !717, metadata !DIExpression()), !dbg !718
  %81 = getelementptr inbounds %struct.tcphdr, ptr %55, i64 1, !dbg !721
  %82 = icmp ugt ptr %81, %12, !dbg !723
  br i1 %82, label %155, label %83, !dbg !724

83:                                               ; preds = %61
  %84 = getelementptr inbounds %struct.tcphdr, ptr %55, i64 0, i32 4, !dbg !725
  %85 = load i16, ptr %84, align 4, !dbg !725
  %86 = lshr i16 %85, 2, !dbg !726
  %87 = and i16 %86, 60, !dbg !726
  call void @llvm.dbg.value(metadata i16 %87, metadata !716, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !718
  %88 = icmp ult i16 %87, 20, !dbg !727
  br i1 %88, label %155, label %89, !dbg !729

89:                                               ; preds = %83
  %90 = zext i16 %87 to i64
  %91 = getelementptr i8, ptr %55, i64 %90, !dbg !730
  %92 = icmp ugt ptr %91, %12, !dbg !732
  br i1 %92, label %155, label %93, !dbg !733

93:                                               ; preds = %89
  call void @llvm.dbg.value(metadata ptr %91, metadata !573, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata ptr %55, metadata !551, metadata !DIExpression()), !dbg !588
  %94 = load i16, ptr %55, align 4, !dbg !734, !tbaa !735
  %95 = tail call i16 @llvm.bswap.i16(i16 %94), !dbg !734
  call void @llvm.dbg.value(metadata i16 %95, metadata !584, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata i16 %95, metadata !585, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %96 = lshr i16 %95, 8
  %97 = xor i16 %96, %95, !dbg !737
  %98 = trunc i16 %97 to i8, !dbg !738
  call void @llvm.dbg.value(metadata i8 %98, metadata !585, metadata !DIExpression()), !dbg !588
  %99 = getelementptr inbounds %struct.flow_id, ptr %6, i64 0, i32 1, !dbg !739
  store i8 %98, ptr %99, align 1, !dbg !740, !tbaa !741
  %100 = getelementptr inbounds %struct.tcphdr, ptr %55, i64 0, i32 1, !dbg !742
  %101 = load i16, ptr %100, align 2, !dbg !742, !tbaa !743
  %102 = tail call i16 @llvm.bswap.i16(i16 %101), !dbg !742
  call void @llvm.dbg.value(metadata i16 %102, metadata !586, metadata !DIExpression()), !dbg !588
  call void @llvm.dbg.value(metadata i16 %102, metadata !587, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !588
  %103 = lshr i16 %102, 8
  %104 = xor i16 %103, %102, !dbg !744
  %105 = trunc i16 %104 to i8, !dbg !745
  call void @llvm.dbg.value(metadata i8 %105, metadata !587, metadata !DIExpression()), !dbg !588
  %106 = getelementptr inbounds %struct.flow_id, ptr %6, i64 0, i32 3, !dbg !746
  store i8 %105, ptr %106, align 1, !dbg !747, !tbaa !748
  call void @llvm.dbg.value(metadata ptr %6, metadata !749, metadata !DIExpression()), !dbg !756
  call void @llvm.dbg.value(metadata i32 1, metadata !754, metadata !DIExpression()), !dbg !756
  call void @llvm.dbg.value(metadata ptr %0, metadata !755, metadata !DIExpression()), !dbg !756
  call void @llvm.dbg.value(metadata ptr %6, metadata !387, metadata !DIExpression()), !dbg !758
  call void @llvm.dbg.value(metadata i32 1, metadata !388, metadata !DIExpression()), !dbg !758
  %107 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @event_enqueue.____fmt.1, i32 noundef 10) #6, !dbg !760
  %108 = load i32, ptr %6, align 8, !dbg !762, !tbaa.struct !763
  call void @llvm.dbg.value(metadata i32 %108, metadata !389, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 32)), !dbg !765
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3)
  store i32 %108, ptr %3, align 4
  call void @llvm.dbg.declare(metadata ptr %3, metadata !766, metadata !DIExpression()), !dbg !776
  call void @llvm.dbg.value(metadata ptr undef, metadata !772, metadata !DIExpression()), !dbg !778
  %109 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @head_tail_hash, ptr noundef nonnull %3) #6, !dbg !779
  %110 = icmp eq ptr %109, null, !dbg !780
  br i1 %110, label %112, label %111, !dbg !781

111:                                              ; preds = %93
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !782
  call void @llvm.dbg.value(metadata ptr %109, metadata !393, metadata !DIExpression()), !dbg !765
  br label %116, !dbg !783

112:                                              ; preds = %93
  call void @llvm.lifetime.start.p0(i64 24, ptr nonnull %4) #6, !dbg !784
  call void @llvm.dbg.declare(metadata ptr %4, metadata !773, metadata !DIExpression()), !dbg !785
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(24) %4, i8 0, i64 24, i1 false), !dbg !785
  %113 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @head_tail_hash, ptr noundef nonnull %3, ptr noundef nonnull %4, i64 noundef 1) #6, !dbg !786
  %114 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @head_tail_hash, ptr noundef nonnull %3) #6, !dbg !787
  call void @llvm.lifetime.end.p0(i64 24, ptr nonnull %4) #6, !dbg !788
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !782
  call void @llvm.dbg.value(metadata ptr %114, metadata !393, metadata !DIExpression()), !dbg !765
  %115 = icmp eq ptr %114, null, !dbg !789
  br i1 %115, label %147, label %116, !dbg !783

116:                                              ; preds = %112, %111
  %117 = phi ptr [ %109, %111 ], [ %114, %112 ]
  %118 = getelementptr inbounds %struct.queue_head_tail, ptr %117, i64 0, i32 1, !dbg !791
  call void @llvm.dbg.value(metadata i32 %108, metadata !440, metadata !DIExpression()), !dbg !793
  call void @llvm.dbg.value(metadata ptr @outer_net_hash, metadata !438, metadata !DIExpression()), !dbg !793
  call void @llvm.dbg.value(metadata ptr %6, metadata !439, metadata !DIExpression()), !dbg !793
  call void @llvm.dbg.value(metadata ptr %114, metadata !441, metadata !DIExpression()), !dbg !793
  call void @llvm.dbg.value(metadata ptr %118, metadata !442, metadata !DIExpression()), !dbg !793
  %119 = load i32, ptr %117, align 4, !dbg !795, !tbaa !498
  %120 = icmp eq i32 %119, 0, !dbg !797
  %121 = load i32, ptr %118, align 4, !dbg !798, !tbaa !498
  %122 = icmp eq i32 %121, 9
  %123 = select i1 %120, i1 %122, i1 false, !dbg !799
  %124 = add nsw i32 %121, 1
  %125 = icmp eq i32 %119, %124
  %126 = select i1 %123, i1 true, i1 %125, !dbg !799
  br i1 %126, label %127, label %129, !dbg !799

127:                                              ; preds = %116
  %128 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @try_to_enqueue.____fmt, i32 noundef 39) #6, !dbg !800
  br label %145, !dbg !803

129:                                              ; preds = %116
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2) #6, !dbg !804
  call void @llvm.dbg.declare(metadata ptr %2, metadata !443, metadata !DIExpression()), !dbg !805
  store i32 0, ptr %2, align 4, !dbg !805
  %130 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @outer_net_hash, ptr noundef nonnull %2) #6, !dbg !806
  call void @llvm.dbg.value(metadata ptr %130, metadata !444, metadata !DIExpression()), !dbg !793
  %131 = icmp eq ptr %130, null, !dbg !807
  br i1 %131, label %132, label %134, !dbg !809

132:                                              ; preds = %129
  %133 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @try_to_enqueue.____fmt.6, i32 noundef 34) #6, !dbg !810
  br label %139, !dbg !813

134:                                              ; preds = %129
  %135 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull %130, ptr noundef nonnull %118, ptr noundef nonnull %6, i64 noundef 0) #6, !dbg !814
  %136 = icmp eq i64 %135, 0, !dbg !814
  br i1 %136, label %140, label %137, !dbg !816

137:                                              ; preds = %134
  %138 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @try_to_enqueue.____fmt.7, i32 noundef 37) #6, !dbg !817
  br label %139, !dbg !820

139:                                              ; preds = %137, %132
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2) #6, !dbg !821
  br label %145, !dbg !803

140:                                              ; preds = %134
  %141 = load i32, ptr %118, align 4, !dbg !822, !tbaa !498
  %142 = icmp slt i32 %141, 9, !dbg !824
  %143 = add nsw i32 %141, 1, !dbg !825
  %144 = select i1 %142, i32 %143, i32 0, !dbg !825
  store i32 %144, ptr %118, align 4, !dbg !826, !tbaa !498
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2) #6, !dbg !821
  br label %147, !dbg !803

145:                                              ; preds = %139, %127
  %146 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @event_enqueue.____fmt.2, i32 noundef 24) #6, !dbg !827
  br label %147, !dbg !830

147:                                              ; preds = %112, %140, %145
  call void @llvm.dbg.value(metadata ptr %5, metadata !487, metadata !DIExpression(DW_OP_deref)), !dbg !489
  %148 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @xsks_map, ptr noundef nonnull %5) #6, !dbg !831
  %149 = icmp eq ptr %148, null, !dbg !831
  br i1 %149, label %155, label %150, !dbg !833

150:                                              ; preds = %147
  %151 = load i32, ptr %5, align 4, !dbg !834, !tbaa !498
  call void @llvm.dbg.value(metadata i32 %151, metadata !487, metadata !DIExpression()), !dbg !489
  %152 = sext i32 %151 to i64, !dbg !834
  %153 = call i64 inttoptr (i64 51 to ptr)(ptr noundef nonnull @xsks_map, i64 noundef %152, i64 noundef 0) #6, !dbg !836
  %154 = trunc i64 %153 to i32, !dbg !836
  br label %155, !dbg !837

155:                                              ; preds = %89, %83, %61, %53, %48, %1, %57, %41, %147, %150
  %156 = phi i32 [ %154, %150 ], [ 1, %147 ], [ 1, %41 ], [ 1, %57 ], [ 1, %1 ], [ 1, %48 ], [ 1, %53 ], [ 1, %61 ], [ 1, %83 ], [ 1, %89 ], !dbg !489
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %6) #6, !dbg !838
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5) #6, !dbg !838
  ret i32 %156, !dbg !838
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

; Function Attrs: nounwind memory(none)
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #5

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nounwind memory(none) }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!468, !469, !470, !471}
!llvm.ident = !{!472}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "inner_app_array0", scope: !2, file: !3, line: 37, type: !105, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !58, globals: !84, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "kernel_xdp.c", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "20e1d6b4aa0505fca2667dddc0db3f8e")
!4 = !{!5, !14, !21, !52}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 5436, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "3810ac036d82ed3898d498c10e871015")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "event_type", file: !15, line: 8, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "./common_def.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "7e27be66949ecee640d64158e6b13ecd")
!16 = !{!17, !18, !19, !20}
!17 = !DIEnumerator(name: "APP_EVENT", value: 0)
!18 = !DIEnumerator(name: "NET_EVENT", value: 1)
!19 = !DIEnumerator(name: "TIMER_EVENT", value: 2)
!20 = !DIEnumerator(name: "PROG_EVENT", value: 3)
!21 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !22, line: 28, baseType: !7, size: 32, elements: !23)
!22 = !DIFile(filename: "/usr/include/linux/in.h", directory: "", checksumkind: CSK_MD5, checksum: "078a32220dc819f6a7e2ea3cecc4e133")
!23 = !{!24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51}
!24 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!25 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!26 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!27 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!28 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!29 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!30 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!31 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!32 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!33 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!34 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!35 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!36 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!37 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!38 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!39 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!40 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!41 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!42 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!43 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!44 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!45 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!46 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!47 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!48 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!49 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!50 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!51 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!52 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 1168, baseType: !7, size: 32, elements: !53)
!53 = !{!54, !55, !56, !57}
!54 = !DIEnumerator(name: "BPF_ANY", value: 0)
!55 = !DIEnumerator(name: "BPF_NOEXIST", value: 1)
!56 = !DIEnumerator(name: "BPF_EXIST", value: 2)
!57 = !DIEnumerator(name: "BPF_F_LOCK", value: 4)
!58 = !{!59, !60, !61, !64, !79}
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!60 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !62, line: 24, baseType: !63)
!62 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!63 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "net_event", file: !15, line: 32, size: 128, elements: !66)
!66 = !{!67, !76}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "ev_flow_id", scope: !65, file: !15, line: 33, baseType: !68, size: 32)
!68 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "flow_id", file: !15, line: 15, size: 32, elements: !69)
!69 = !{!70, !73, !74, !75}
!70 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip", scope: !68, file: !15, line: 16, baseType: !71, size: 8)
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !62, line: 21, baseType: !72)
!72 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !68, file: !15, line: 17, baseType: !71, size: 8, offset: 8)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "dest_ip", scope: !68, file: !15, line: 18, baseType: !71, size: 8, offset: 16)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "dest_port", scope: !68, file: !15, line: 19, baseType: !71, size: 8, offset: 24)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !65, file: !15, line: 34, baseType: !77, size: 64, offset: 64)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !62, line: 31, baseType: !78)
!78 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timer_event", file: !15, line: 37, size: 128, elements: !81)
!81 = !{!82, !83}
!82 = !DIDerivedType(tag: DW_TAG_member, name: "ev_flow_id", scope: !80, file: !15, line: 38, baseType: !68, size: 32)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !80, file: !15, line: 39, baseType: !77, size: 64, offset: 64)
!84 = !{!85, !129, !145, !161, !196, !202, !0, !214, !216, !218, !220, !222, !224, !226, !228, !230, !232, !234, !236, !238, !240, !242, !244, !246, !248, !250, !252, !269, !271, !273, !275, !277, !279, !281, !283, !285, !287, !289, !291, !293, !295, !297, !299, !301, !303, !305, !307, !309, !311, !313, !315, !317, !319, !321, !323, !325, !327, !329, !331, !333, !335, !337, !339, !341, !343, !345, !347, !349, !351, !353, !355, !357, !359, !361, !363, !365, !381, !400, !402, !407, !410, !412, !417, !424, !431, !448, !453, !458, !463}
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(name: "outer_app_hash", scope: !2, file: !3, line: 48, type: !87, isLocal: false, isDefinition: true)
!87 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_app_hash", file: !3, line: 43, size: 192, elements: !88)
!88 = !{!89, !95, !97, !102}
!89 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !87, file: !3, line: 44, baseType: !90, size: 64)
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!91 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 416, elements: !93)
!92 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!93 = !{!94}
!94 = !DISubrange(count: 13)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !87, file: !3, line: 45, baseType: !96, size: 64, offset: 64)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !87, file: !3, line: 46, baseType: !98, size: 64, offset: 128)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 640, elements: !100)
!100 = !{!101}
!101 = !DISubrange(count: 20)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !87, file: !3, line: 47, baseType: !103, offset: 192)
!103 = !DICompositeType(tag: DW_TAG_array_type, baseType: !104, elements: !127)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_app_array", file: !3, line: 32, size: 256, elements: !106)
!106 = !{!107, !112, !115, !122}
!107 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !105, file: !3, line: 33, baseType: !108, size: 64)
!108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !109, size: 64)
!109 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 64, elements: !110)
!110 = !{!111}
!111 = !DISubrange(count: 2)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !105, file: !3, line: 34, baseType: !113, size: 64, offset: 64)
!113 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !114, size: 64)
!114 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !62, line: 27, baseType: !7)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !105, file: !3, line: 35, baseType: !116, size: 64, offset: 128)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "app_event", file: !15, line: 26, size: 192, elements: !118)
!118 = !{!119, !120, !121}
!119 = !DIDerivedType(tag: DW_TAG_member, name: "ev_flow_id", scope: !117, file: !15, line: 27, baseType: !68, size: 32)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "occupied", scope: !117, file: !15, line: 28, baseType: !77, size: 64, offset: 64)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !117, file: !15, line: 29, baseType: !77, size: 64, offset: 128)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !105, file: !3, line: 36, baseType: !123, size: 64, offset: 192)
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 320, elements: !125)
!125 = !{!126}
!126 = !DISubrange(count: 10)
!127 = !{!128}
!128 = !DISubrange(count: -1)
!129 = !DIGlobalVariableExpression(var: !130, expr: !DIExpression())
!130 = distinct !DIGlobalVariable(name: "outer_net_hash", scope: !2, file: !3, line: 85, type: !131, isLocal: false, isDefinition: true)
!131 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_net_hash", file: !3, line: 80, size: 192, elements: !132)
!132 = !{!133, !134, !135, !136}
!133 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !131, file: !3, line: 81, baseType: !90, size: 64)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !131, file: !3, line: 82, baseType: !96, size: 64, offset: 64)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !131, file: !3, line: 83, baseType: !98, size: 64, offset: 128)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !131, file: !3, line: 84, baseType: !137, offset: 192)
!137 = !DICompositeType(tag: DW_TAG_array_type, baseType: !138, elements: !127)
!138 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !139, size: 64)
!139 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_net_array", file: !3, line: 69, size: 256, elements: !140)
!140 = !{!141, !142, !143, !144}
!141 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !139, file: !3, line: 70, baseType: !108, size: 64)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !139, file: !3, line: 71, baseType: !113, size: 64, offset: 64)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !139, file: !3, line: 72, baseType: !64, size: 64, offset: 128)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !139, file: !3, line: 73, baseType: !123, size: 64, offset: 192)
!145 = !DIGlobalVariableExpression(var: !146, expr: !DIExpression())
!146 = distinct !DIGlobalVariable(name: "outer_timer_hash", scope: !2, file: !3, line: 112, type: !147, isLocal: false, isDefinition: true)
!147 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_timer_hash", file: !3, line: 107, size: 192, elements: !148)
!148 = !{!149, !150, !151, !152}
!149 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !147, file: !3, line: 108, baseType: !90, size: 64)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !147, file: !3, line: 109, baseType: !96, size: 64, offset: 64)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !147, file: !3, line: 110, baseType: !98, size: 64, offset: 128)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !147, file: !3, line: 111, baseType: !153, offset: 192)
!153 = !DICompositeType(tag: DW_TAG_array_type, baseType: !154, elements: !127)
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !155, size: 64)
!155 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_timer_array", file: !3, line: 96, size: 256, elements: !156)
!156 = !{!157, !158, !159, !160}
!157 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !155, file: !3, line: 97, baseType: !108, size: 64)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !155, file: !3, line: 98, baseType: !113, size: 64, offset: 64)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !155, file: !3, line: 99, baseType: !64, size: 64, offset: 128)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !155, file: !3, line: 100, baseType: !123, size: 64, offset: 192)
!161 = !DIGlobalVariableExpression(var: !162, expr: !DIExpression())
!162 = distinct !DIGlobalVariable(name: "outer_flow_info_array", scope: !2, file: !3, line: 137, type: !163, isLocal: false, isDefinition: true)
!163 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_flow_info_array", file: !3, line: 132, size: 192, elements: !164)
!164 = !{!165, !170, !175, !176}
!165 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !163, file: !3, line: 133, baseType: !166, size: 64)
!166 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !167, size: 64)
!167 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 384, elements: !168)
!168 = !{!169}
!169 = !DISubrange(count: 12)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !163, file: !3, line: 134, baseType: !171, size: 64, offset: 64)
!171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !172, size: 64)
!172 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 256, elements: !173)
!173 = !{!174}
!174 = !DISubrange(count: 8)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !163, file: !3, line: 135, baseType: !113, size: 64, offset: 128)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !163, file: !3, line: 136, baseType: !177, offset: 192)
!177 = !DICompositeType(tag: DW_TAG_array_type, baseType: !178, elements: !127)
!178 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !179, size: 64)
!179 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_flow_info_hash", file: !3, line: 123, size: 256, elements: !180)
!180 = !{!181, !186, !187, !195}
!181 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !179, file: !3, line: 124, baseType: !182, size: 64)
!182 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !183, size: 64)
!183 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 32, elements: !184)
!184 = !{!185}
!185 = !DISubrange(count: 1)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !179, file: !3, line: 125, baseType: !96, size: 64, offset: 64)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !179, file: !3, line: 126, baseType: !188, size: 64, offset: 128)
!188 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !189, size: 64)
!189 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "flow_info", file: !15, line: 63, size: 128, elements: !190)
!190 = !{!191, !192, !193, !194}
!191 = !DIDerivedType(tag: DW_TAG_member, name: "len_app_queue", scope: !189, file: !15, line: 64, baseType: !114, size: 32)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "len_net_queue", scope: !189, file: !15, line: 65, baseType: !114, size: 32, offset: 32)
!193 = !DIDerivedType(tag: DW_TAG_member, name: "len_timer_queue", scope: !189, file: !15, line: 66, baseType: !114, size: 32, offset: 64)
!194 = !DIDerivedType(tag: DW_TAG_member, name: "len_prog_queue", scope: !189, file: !15, line: 67, baseType: !114, size: 32, offset: 96)
!195 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !179, file: !3, line: 127, baseType: !98, size: 64, offset: 192)
!196 = !DIGlobalVariableExpression(var: !197, expr: !DIExpression())
!197 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 471, type: !198, isLocal: false, isDefinition: true)
!198 = !DICompositeType(tag: DW_TAG_array_type, baseType: !199, size: 32, elements: !200)
!199 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!200 = !{!201}
!201 = !DISubrange(count: 4)
!202 = !DIGlobalVariableExpression(var: !203, expr: !DIExpression())
!203 = distinct !DIGlobalVariable(name: "xsks_map", scope: !2, file: !3, line: 28, type: !204, isLocal: false, isDefinition: true)
!204 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 23, size: 256, elements: !205)
!205 = !{!206, !211, !212, !213}
!206 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !204, file: !3, line: 24, baseType: !207, size: 64)
!207 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !208, size: 64)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !92, size: 544, elements: !209)
!209 = !{!210}
!210 = !DISubrange(count: 17)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !204, file: !3, line: 25, baseType: !113, size: 64, offset: 64)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !204, file: !3, line: 26, baseType: !113, size: 64, offset: 128)
!213 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !204, file: !3, line: 27, baseType: !171, size: 64, offset: 192)
!214 = !DIGlobalVariableExpression(var: !215, expr: !DIExpression())
!215 = distinct !DIGlobalVariable(name: "inner_app_array1", scope: !2, file: !3, line: 37, type: !105, isLocal: false, isDefinition: true)
!216 = !DIGlobalVariableExpression(var: !217, expr: !DIExpression())
!217 = distinct !DIGlobalVariable(name: "inner_app_array2", scope: !2, file: !3, line: 37, type: !105, isLocal: false, isDefinition: true)
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(name: "inner_app_array3", scope: !2, file: !3, line: 37, type: !105, isLocal: false, isDefinition: true)
!220 = !DIGlobalVariableExpression(var: !221, expr: !DIExpression())
!221 = distinct !DIGlobalVariable(name: "inner_app_array4", scope: !2, file: !3, line: 38, type: !105, isLocal: false, isDefinition: true)
!222 = !DIGlobalVariableExpression(var: !223, expr: !DIExpression())
!223 = distinct !DIGlobalVariable(name: "inner_app_array5", scope: !2, file: !3, line: 38, type: !105, isLocal: false, isDefinition: true)
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(name: "inner_app_array6", scope: !2, file: !3, line: 38, type: !105, isLocal: false, isDefinition: true)
!226 = !DIGlobalVariableExpression(var: !227, expr: !DIExpression())
!227 = distinct !DIGlobalVariable(name: "inner_app_array7", scope: !2, file: !3, line: 38, type: !105, isLocal: false, isDefinition: true)
!228 = !DIGlobalVariableExpression(var: !229, expr: !DIExpression())
!229 = distinct !DIGlobalVariable(name: "inner_app_array8", scope: !2, file: !3, line: 39, type: !105, isLocal: false, isDefinition: true)
!230 = !DIGlobalVariableExpression(var: !231, expr: !DIExpression())
!231 = distinct !DIGlobalVariable(name: "inner_app_array9", scope: !2, file: !3, line: 39, type: !105, isLocal: false, isDefinition: true)
!232 = !DIGlobalVariableExpression(var: !233, expr: !DIExpression())
!233 = distinct !DIGlobalVariable(name: "inner_app_array10", scope: !2, file: !3, line: 39, type: !105, isLocal: false, isDefinition: true)
!234 = !DIGlobalVariableExpression(var: !235, expr: !DIExpression())
!235 = distinct !DIGlobalVariable(name: "inner_app_array11", scope: !2, file: !3, line: 39, type: !105, isLocal: false, isDefinition: true)
!236 = !DIGlobalVariableExpression(var: !237, expr: !DIExpression())
!237 = distinct !DIGlobalVariable(name: "inner_app_array12", scope: !2, file: !3, line: 40, type: !105, isLocal: false, isDefinition: true)
!238 = !DIGlobalVariableExpression(var: !239, expr: !DIExpression())
!239 = distinct !DIGlobalVariable(name: "inner_app_array13", scope: !2, file: !3, line: 40, type: !105, isLocal: false, isDefinition: true)
!240 = !DIGlobalVariableExpression(var: !241, expr: !DIExpression())
!241 = distinct !DIGlobalVariable(name: "inner_app_array14", scope: !2, file: !3, line: 40, type: !105, isLocal: false, isDefinition: true)
!242 = !DIGlobalVariableExpression(var: !243, expr: !DIExpression())
!243 = distinct !DIGlobalVariable(name: "inner_app_array15", scope: !2, file: !3, line: 40, type: !105, isLocal: false, isDefinition: true)
!244 = !DIGlobalVariableExpression(var: !245, expr: !DIExpression())
!245 = distinct !DIGlobalVariable(name: "inner_app_array16", scope: !2, file: !3, line: 41, type: !105, isLocal: false, isDefinition: true)
!246 = !DIGlobalVariableExpression(var: !247, expr: !DIExpression())
!247 = distinct !DIGlobalVariable(name: "inner_app_array17", scope: !2, file: !3, line: 41, type: !105, isLocal: false, isDefinition: true)
!248 = !DIGlobalVariableExpression(var: !249, expr: !DIExpression())
!249 = distinct !DIGlobalVariable(name: "inner_app_array18", scope: !2, file: !3, line: 41, type: !105, isLocal: false, isDefinition: true)
!250 = !DIGlobalVariableExpression(var: !251, expr: !DIExpression())
!251 = distinct !DIGlobalVariable(name: "inner_app_array19", scope: !2, file: !3, line: 41, type: !105, isLocal: false, isDefinition: true)
!252 = !DIGlobalVariableExpression(var: !253, expr: !DIExpression())
!253 = distinct !DIGlobalVariable(name: "head_tail_hash", scope: !2, file: !3, line: 64, type: !254, isLocal: false, isDefinition: true)
!254 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 59, size: 256, elements: !255)
!255 = !{!256, !257, !258, !268}
!256 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !254, file: !3, line: 60, baseType: !182, size: 64)
!257 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !254, file: !3, line: 61, baseType: !96, size: 64, offset: 64)
!258 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !254, file: !3, line: 62, baseType: !259, size: 64, offset: 128)
!259 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !260, size: 64)
!260 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "queue_head_tail", file: !15, line: 54, size: 192, elements: !261)
!261 = !{!262, !263, !264, !265, !266, !267}
!262 = !DIDerivedType(tag: DW_TAG_member, name: "net_head", scope: !260, file: !15, line: 55, baseType: !114, size: 32)
!263 = !DIDerivedType(tag: DW_TAG_member, name: "net_tail", scope: !260, file: !15, line: 56, baseType: !114, size: 32, offset: 32)
!264 = !DIDerivedType(tag: DW_TAG_member, name: "timer_head", scope: !260, file: !15, line: 57, baseType: !114, size: 32, offset: 64)
!265 = !DIDerivedType(tag: DW_TAG_member, name: "timer_tail", scope: !260, file: !15, line: 58, baseType: !114, size: 32, offset: 96)
!266 = !DIDerivedType(tag: DW_TAG_member, name: "prog_head", scope: !260, file: !15, line: 59, baseType: !114, size: 32, offset: 128)
!267 = !DIDerivedType(tag: DW_TAG_member, name: "prog_tail", scope: !260, file: !15, line: 60, baseType: !114, size: 32, offset: 160)
!268 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !254, file: !3, line: 63, baseType: !123, size: 64, offset: 192)
!269 = !DIGlobalVariableExpression(var: !270, expr: !DIExpression())
!270 = distinct !DIGlobalVariable(name: "inner_net_array0", scope: !2, file: !3, line: 74, type: !139, isLocal: false, isDefinition: true)
!271 = !DIGlobalVariableExpression(var: !272, expr: !DIExpression())
!272 = distinct !DIGlobalVariable(name: "inner_net_array1", scope: !2, file: !3, line: 74, type: !139, isLocal: false, isDefinition: true)
!273 = !DIGlobalVariableExpression(var: !274, expr: !DIExpression())
!274 = distinct !DIGlobalVariable(name: "inner_net_array2", scope: !2, file: !3, line: 74, type: !139, isLocal: false, isDefinition: true)
!275 = !DIGlobalVariableExpression(var: !276, expr: !DIExpression())
!276 = distinct !DIGlobalVariable(name: "inner_net_array3", scope: !2, file: !3, line: 74, type: !139, isLocal: false, isDefinition: true)
!277 = !DIGlobalVariableExpression(var: !278, expr: !DIExpression())
!278 = distinct !DIGlobalVariable(name: "inner_net_array4", scope: !2, file: !3, line: 75, type: !139, isLocal: false, isDefinition: true)
!279 = !DIGlobalVariableExpression(var: !280, expr: !DIExpression())
!280 = distinct !DIGlobalVariable(name: "inner_net_array5", scope: !2, file: !3, line: 75, type: !139, isLocal: false, isDefinition: true)
!281 = !DIGlobalVariableExpression(var: !282, expr: !DIExpression())
!282 = distinct !DIGlobalVariable(name: "inner_net_array6", scope: !2, file: !3, line: 75, type: !139, isLocal: false, isDefinition: true)
!283 = !DIGlobalVariableExpression(var: !284, expr: !DIExpression())
!284 = distinct !DIGlobalVariable(name: "inner_net_array7", scope: !2, file: !3, line: 75, type: !139, isLocal: false, isDefinition: true)
!285 = !DIGlobalVariableExpression(var: !286, expr: !DIExpression())
!286 = distinct !DIGlobalVariable(name: "inner_net_array8", scope: !2, file: !3, line: 76, type: !139, isLocal: false, isDefinition: true)
!287 = !DIGlobalVariableExpression(var: !288, expr: !DIExpression())
!288 = distinct !DIGlobalVariable(name: "inner_net_array9", scope: !2, file: !3, line: 76, type: !139, isLocal: false, isDefinition: true)
!289 = !DIGlobalVariableExpression(var: !290, expr: !DIExpression())
!290 = distinct !DIGlobalVariable(name: "inner_net_array10", scope: !2, file: !3, line: 76, type: !139, isLocal: false, isDefinition: true)
!291 = !DIGlobalVariableExpression(var: !292, expr: !DIExpression())
!292 = distinct !DIGlobalVariable(name: "inner_net_array11", scope: !2, file: !3, line: 76, type: !139, isLocal: false, isDefinition: true)
!293 = !DIGlobalVariableExpression(var: !294, expr: !DIExpression())
!294 = distinct !DIGlobalVariable(name: "inner_net_array12", scope: !2, file: !3, line: 77, type: !139, isLocal: false, isDefinition: true)
!295 = !DIGlobalVariableExpression(var: !296, expr: !DIExpression())
!296 = distinct !DIGlobalVariable(name: "inner_net_array13", scope: !2, file: !3, line: 77, type: !139, isLocal: false, isDefinition: true)
!297 = !DIGlobalVariableExpression(var: !298, expr: !DIExpression())
!298 = distinct !DIGlobalVariable(name: "inner_net_array14", scope: !2, file: !3, line: 77, type: !139, isLocal: false, isDefinition: true)
!299 = !DIGlobalVariableExpression(var: !300, expr: !DIExpression())
!300 = distinct !DIGlobalVariable(name: "inner_net_array15", scope: !2, file: !3, line: 77, type: !139, isLocal: false, isDefinition: true)
!301 = !DIGlobalVariableExpression(var: !302, expr: !DIExpression())
!302 = distinct !DIGlobalVariable(name: "inner_net_array16", scope: !2, file: !3, line: 78, type: !139, isLocal: false, isDefinition: true)
!303 = !DIGlobalVariableExpression(var: !304, expr: !DIExpression())
!304 = distinct !DIGlobalVariable(name: "inner_net_array17", scope: !2, file: !3, line: 78, type: !139, isLocal: false, isDefinition: true)
!305 = !DIGlobalVariableExpression(var: !306, expr: !DIExpression())
!306 = distinct !DIGlobalVariable(name: "inner_net_array18", scope: !2, file: !3, line: 78, type: !139, isLocal: false, isDefinition: true)
!307 = !DIGlobalVariableExpression(var: !308, expr: !DIExpression())
!308 = distinct !DIGlobalVariable(name: "inner_net_array19", scope: !2, file: !3, line: 78, type: !139, isLocal: false, isDefinition: true)
!309 = !DIGlobalVariableExpression(var: !310, expr: !DIExpression())
!310 = distinct !DIGlobalVariable(name: "inner_timer_array0", scope: !2, file: !3, line: 101, type: !155, isLocal: false, isDefinition: true)
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(name: "inner_timer_array1", scope: !2, file: !3, line: 101, type: !155, isLocal: false, isDefinition: true)
!313 = !DIGlobalVariableExpression(var: !314, expr: !DIExpression())
!314 = distinct !DIGlobalVariable(name: "inner_timer_array2", scope: !2, file: !3, line: 101, type: !155, isLocal: false, isDefinition: true)
!315 = !DIGlobalVariableExpression(var: !316, expr: !DIExpression())
!316 = distinct !DIGlobalVariable(name: "inner_timer_array3", scope: !2, file: !3, line: 101, type: !155, isLocal: false, isDefinition: true)
!317 = !DIGlobalVariableExpression(var: !318, expr: !DIExpression())
!318 = distinct !DIGlobalVariable(name: "inner_timer_array4", scope: !2, file: !3, line: 102, type: !155, isLocal: false, isDefinition: true)
!319 = !DIGlobalVariableExpression(var: !320, expr: !DIExpression())
!320 = distinct !DIGlobalVariable(name: "inner_timer_array5", scope: !2, file: !3, line: 102, type: !155, isLocal: false, isDefinition: true)
!321 = !DIGlobalVariableExpression(var: !322, expr: !DIExpression())
!322 = distinct !DIGlobalVariable(name: "inner_timer_array6", scope: !2, file: !3, line: 102, type: !155, isLocal: false, isDefinition: true)
!323 = !DIGlobalVariableExpression(var: !324, expr: !DIExpression())
!324 = distinct !DIGlobalVariable(name: "inner_timer_array7", scope: !2, file: !3, line: 102, type: !155, isLocal: false, isDefinition: true)
!325 = !DIGlobalVariableExpression(var: !326, expr: !DIExpression())
!326 = distinct !DIGlobalVariable(name: "inner_timer_array8", scope: !2, file: !3, line: 103, type: !155, isLocal: false, isDefinition: true)
!327 = !DIGlobalVariableExpression(var: !328, expr: !DIExpression())
!328 = distinct !DIGlobalVariable(name: "inner_timer_array9", scope: !2, file: !3, line: 103, type: !155, isLocal: false, isDefinition: true)
!329 = !DIGlobalVariableExpression(var: !330, expr: !DIExpression())
!330 = distinct !DIGlobalVariable(name: "inner_timer_array10", scope: !2, file: !3, line: 103, type: !155, isLocal: false, isDefinition: true)
!331 = !DIGlobalVariableExpression(var: !332, expr: !DIExpression())
!332 = distinct !DIGlobalVariable(name: "inner_timer_array11", scope: !2, file: !3, line: 103, type: !155, isLocal: false, isDefinition: true)
!333 = !DIGlobalVariableExpression(var: !334, expr: !DIExpression())
!334 = distinct !DIGlobalVariable(name: "inner_timer_array12", scope: !2, file: !3, line: 104, type: !155, isLocal: false, isDefinition: true)
!335 = !DIGlobalVariableExpression(var: !336, expr: !DIExpression())
!336 = distinct !DIGlobalVariable(name: "inner_timer_array13", scope: !2, file: !3, line: 104, type: !155, isLocal: false, isDefinition: true)
!337 = !DIGlobalVariableExpression(var: !338, expr: !DIExpression())
!338 = distinct !DIGlobalVariable(name: "inner_timer_array14", scope: !2, file: !3, line: 104, type: !155, isLocal: false, isDefinition: true)
!339 = !DIGlobalVariableExpression(var: !340, expr: !DIExpression())
!340 = distinct !DIGlobalVariable(name: "inner_timer_array15", scope: !2, file: !3, line: 104, type: !155, isLocal: false, isDefinition: true)
!341 = !DIGlobalVariableExpression(var: !342, expr: !DIExpression())
!342 = distinct !DIGlobalVariable(name: "inner_timer_array16", scope: !2, file: !3, line: 105, type: !155, isLocal: false, isDefinition: true)
!343 = !DIGlobalVariableExpression(var: !344, expr: !DIExpression())
!344 = distinct !DIGlobalVariable(name: "inner_timer_array17", scope: !2, file: !3, line: 105, type: !155, isLocal: false, isDefinition: true)
!345 = !DIGlobalVariableExpression(var: !346, expr: !DIExpression())
!346 = distinct !DIGlobalVariable(name: "inner_timer_array18", scope: !2, file: !3, line: 105, type: !155, isLocal: false, isDefinition: true)
!347 = !DIGlobalVariableExpression(var: !348, expr: !DIExpression())
!348 = distinct !DIGlobalVariable(name: "inner_timer_array19", scope: !2, file: !3, line: 105, type: !155, isLocal: false, isDefinition: true)
!349 = !DIGlobalVariableExpression(var: !350, expr: !DIExpression())
!350 = distinct !DIGlobalVariable(name: "inner_flow_info_hash0", scope: !2, file: !3, line: 128, type: !179, isLocal: false, isDefinition: true)
!351 = !DIGlobalVariableExpression(var: !352, expr: !DIExpression())
!352 = distinct !DIGlobalVariable(name: "inner_flow_info_hash1", scope: !2, file: !3, line: 128, type: !179, isLocal: false, isDefinition: true)
!353 = !DIGlobalVariableExpression(var: !354, expr: !DIExpression())
!354 = distinct !DIGlobalVariable(name: "inner_flow_info_hash2", scope: !2, file: !3, line: 128, type: !179, isLocal: false, isDefinition: true)
!355 = !DIGlobalVariableExpression(var: !356, expr: !DIExpression())
!356 = distinct !DIGlobalVariable(name: "inner_flow_info_hash3", scope: !2, file: !3, line: 129, type: !179, isLocal: false, isDefinition: true)
!357 = !DIGlobalVariableExpression(var: !358, expr: !DIExpression())
!358 = distinct !DIGlobalVariable(name: "inner_flow_info_hash4", scope: !2, file: !3, line: 129, type: !179, isLocal: false, isDefinition: true)
!359 = !DIGlobalVariableExpression(var: !360, expr: !DIExpression())
!360 = distinct !DIGlobalVariable(name: "inner_flow_info_hash5", scope: !2, file: !3, line: 129, type: !179, isLocal: false, isDefinition: true)
!361 = !DIGlobalVariableExpression(var: !362, expr: !DIExpression())
!362 = distinct !DIGlobalVariable(name: "inner_flow_info_hash6", scope: !2, file: !3, line: 130, type: !179, isLocal: false, isDefinition: true)
!363 = !DIGlobalVariableExpression(var: !364, expr: !DIExpression())
!364 = distinct !DIGlobalVariable(name: "inner_flow_info_hash7", scope: !2, file: !3, line: 130, type: !179, isLocal: false, isDefinition: true)
!365 = !DIGlobalVariableExpression(var: !366, expr: !DIExpression())
!366 = distinct !DIGlobalVariable(name: "timer_array", scope: !2, file: !3, line: 150, type: !367, isLocal: false, isDefinition: true)
!367 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 145, size: 256, elements: !368)
!368 = !{!369, !370, !371, !380}
!369 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !367, file: !3, line: 146, baseType: !108, size: 64)
!370 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !367, file: !3, line: 147, baseType: !113, size: 64, offset: 64)
!371 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !367, file: !3, line: 148, baseType: !372, size: 64, offset: 128)
!372 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !373, size: 64)
!373 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timer_trigger", file: !15, line: 47, size: 256, elements: !374)
!374 = !{!375, !376, !377}
!375 = !DIDerivedType(tag: DW_TAG_member, name: "ev_flow_id", scope: !373, file: !15, line: 48, baseType: !68, size: 32)
!376 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !373, file: !15, line: 49, baseType: !77, size: 64, offset: 64)
!377 = !DIDerivedType(tag: DW_TAG_member, name: "timer", scope: !373, file: !15, line: 50, baseType: !378, size: 128, align: 64, offset: 128)
!378 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_timer", file: !6, line: 6190, size: 128, align: 64, elements: !379)
!379 = !{}
!380 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !367, file: !3, line: 149, baseType: !171, size: 64, offset: 192)
!381 = !DIGlobalVariableExpression(var: !382, expr: !DIExpression())
!382 = distinct !DIGlobalVariable(name: "____fmt", scope: !383, file: !3, line: 398, type: !398, isLocal: true, isDefinition: true)
!383 = distinct !DISubprogram(name: "event_enqueue", scope: !3, file: !3, line: 396, type: !384, scopeLine: 396, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !386)
!384 = !DISubroutineType(types: !385)
!385 = !{null, !59, !14}
!386 = !{!387, !388, !389, !393, !394, !397}
!387 = !DILocalVariable(name: "event", arg: 1, scope: !383, file: !3, line: 396, type: !59)
!388 = !DILocalVariable(name: "type", arg: 2, scope: !383, file: !3, line: 396, type: !14)
!389 = !DILocalVariable(name: "enq_event", scope: !390, file: !3, line: 402, type: !65)
!390 = distinct !DILexicalBlock(scope: !391, file: !3, line: 400, column: 34)
!391 = distinct !DILexicalBlock(scope: !392, file: !3, line: 400, column: 15)
!392 = distinct !DILexicalBlock(scope: !383, file: !3, line: 397, column: 8)
!393 = !DILocalVariable(name: "ht_info", scope: !390, file: !3, line: 403, type: !259)
!394 = !DILocalVariable(name: "enq_event", scope: !395, file: !3, line: 414, type: !80)
!395 = distinct !DILexicalBlock(scope: !396, file: !3, line: 412, column: 36)
!396 = distinct !DILexicalBlock(scope: !391, file: !3, line: 412, column: 15)
!397 = !DILocalVariable(name: "ht_info", scope: !395, file: !3, line: 415, type: !259)
!398 = !DICompositeType(tag: DW_TAG_array_type, baseType: !399, size: 80, elements: !125)
!399 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !199)
!400 = !DIGlobalVariableExpression(var: !401, expr: !DIExpression())
!401 = distinct !DIGlobalVariable(name: "____fmt", scope: !383, file: !3, line: 401, type: !398, isLocal: true, isDefinition: true)
!402 = !DIGlobalVariableExpression(var: !403, expr: !DIExpression())
!403 = distinct !DIGlobalVariable(name: "____fmt", scope: !383, file: !3, line: 409, type: !404, isLocal: true, isDefinition: true)
!404 = !DICompositeType(tag: DW_TAG_array_type, baseType: !399, size: 192, elements: !405)
!405 = !{!406}
!406 = !DISubrange(count: 24)
!407 = !DIGlobalVariableExpression(var: !408, expr: !DIExpression())
!408 = distinct !DIGlobalVariable(name: "____fmt", scope: !383, file: !3, line: 413, type: !409, isLocal: true, isDefinition: true)
!409 = !DICompositeType(tag: DW_TAG_array_type, baseType: !399, size: 96, elements: !168)
!410 = !DIGlobalVariableExpression(var: !411, expr: !DIExpression())
!411 = distinct !DIGlobalVariable(name: "____fmt", scope: !383, file: !3, line: 420, type: !404, isLocal: true, isDefinition: true)
!412 = !DIGlobalVariableExpression(var: !413, expr: !DIExpression())
!413 = distinct !DIGlobalVariable(name: "____fmt", scope: !383, file: !3, line: 424, type: !414, isLocal: true, isDefinition: true)
!414 = !DICompositeType(tag: DW_TAG_array_type, baseType: !399, size: 88, elements: !415)
!415 = !{!416}
!416 = !DISubrange(count: 11)
!417 = !DIGlobalVariableExpression(var: !418, expr: !DIExpression())
!418 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !419, line: 177, type: !420, isLocal: true, isDefinition: true)
!419 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!420 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !421, size: 64)
!421 = !DISubroutineType(types: !422)
!422 = !{!60, !423, !114, null}
!423 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !399, size: 64)
!424 = !DIGlobalVariableExpression(var: !425, expr: !DIExpression())
!425 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !419, line: 78, type: !426, isLocal: true, isDefinition: true)
!426 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !427, size: 64)
!427 = !DISubroutineType(types: !428)
!428 = !{!60, !59, !429, !429, !77}
!429 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !430, size: 64)
!430 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!431 = !DIGlobalVariableExpression(var: !432, expr: !DIExpression())
!432 = distinct !DIGlobalVariable(name: "____fmt", scope: !433, file: !3, line: 364, type: !445, isLocal: true, isDefinition: true)
!433 = distinct !DISubprogram(name: "try_to_enqueue", scope: !3, file: !3, line: 361, type: !434, scopeLine: 361, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !437)
!434 = !DISubroutineType(types: !435)
!435 = !{!92, !59, !59, !68, !436, !436}
!436 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!437 = !{!438, !439, !440, !441, !442, !443, !444}
!438 = !DILocalVariable(name: "map", arg: 1, scope: !433, file: !3, line: 361, type: !59)
!439 = !DILocalVariable(name: "event", arg: 2, scope: !433, file: !3, line: 361, type: !59)
!440 = !DILocalVariable(name: "flow", arg: 3, scope: !433, file: !3, line: 361, type: !68)
!441 = !DILocalVariable(name: "head", arg: 4, scope: !433, file: !3, line: 361, type: !436)
!442 = !DILocalVariable(name: "tail", arg: 5, scope: !433, file: !3, line: 361, type: !436)
!443 = !DILocalVariable(name: "key", scope: !433, file: !3, line: 371, type: !68)
!444 = !DILocalVariable(name: "inner_array", scope: !433, file: !3, line: 372, type: !138)
!445 = !DICompositeType(tag: DW_TAG_array_type, baseType: !399, size: 312, elements: !446)
!446 = !{!447}
!447 = !DISubrange(count: 39)
!448 = !DIGlobalVariableExpression(var: !449, expr: !DIExpression())
!449 = distinct !DIGlobalVariable(name: "____fmt", scope: !433, file: !3, line: 374, type: !450, isLocal: true, isDefinition: true)
!450 = !DICompositeType(tag: DW_TAG_array_type, baseType: !399, size: 272, elements: !451)
!451 = !{!452}
!452 = !DISubrange(count: 34)
!453 = !DIGlobalVariableExpression(var: !454, expr: !DIExpression())
!454 = distinct !DIGlobalVariable(name: "____fmt", scope: !433, file: !3, line: 379, type: !455, isLocal: true, isDefinition: true)
!455 = !DICompositeType(tag: DW_TAG_array_type, baseType: !399, size: 296, elements: !456)
!456 = !{!457}
!457 = !DISubrange(count: 37)
!458 = !DIGlobalVariableExpression(var: !459, expr: !DIExpression())
!459 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !419, line: 56, type: !460, isLocal: true, isDefinition: true)
!460 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !461, size: 64)
!461 = !DISubroutineType(types: !462)
!462 = !{!59, !59, !429}
!463 = !DIGlobalVariableExpression(var: !464, expr: !DIExpression())
!464 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !419, line: 1323, type: !465, isLocal: true, isDefinition: true)
!465 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !466, size: 64)
!466 = !DISubroutineType(types: !467)
!467 = !{!60, !59, !77, !77}
!468 = !{i32 7, !"Dwarf Version", i32 5}
!469 = !{i32 2, !"Debug Info Version", i32 3}
!470 = !{i32 1, !"wchar_size", i32 4}
!471 = !{i32 7, !"frame-pointer", i32 2}
!472 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!473 = distinct !DISubprogram(name: "rx_module", scope: !3, file: !3, line: 446, type: !474, scopeLine: 447, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !485)
!474 = !DISubroutineType(types: !475)
!475 = !{!92, !476}
!476 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !477, size: 64)
!477 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5447, size: 192, elements: !478)
!478 = !{!479, !480, !481, !482, !483, !484}
!479 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !477, file: !6, line: 5448, baseType: !114, size: 32)
!480 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !477, file: !6, line: 5449, baseType: !114, size: 32, offset: 32)
!481 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !477, file: !6, line: 5450, baseType: !114, size: 32, offset: 64)
!482 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !477, file: !6, line: 5452, baseType: !114, size: 32, offset: 96)
!483 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !477, file: !6, line: 5453, baseType: !114, size: 32, offset: 128)
!484 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !477, file: !6, line: 5455, baseType: !114, size: 32, offset: 160)
!485 = !{!486, !487, !488}
!486 = !DILocalVariable(name: "ctx", arg: 1, scope: !473, file: !3, line: 446, type: !476)
!487 = !DILocalVariable(name: "rx_queue_index", scope: !473, file: !3, line: 448, type: !92)
!488 = !DILocalVariable(name: "net_ev", scope: !473, file: !3, line: 449, type: !65)
!489 = !DILocation(line: 0, scope: !473)
!490 = !DILocation(line: 448, column: 5, scope: !473)
!491 = !DILocation(line: 448, column: 31, scope: !473)
!492 = !{!493, !494, i64 16}
!493 = !{!"xdp_md", !494, i64 0, !494, i64 4, !494, i64 8, !494, i64 12, !494, i64 16, !494, i64 20}
!494 = !{!"int", !495, i64 0}
!495 = !{!"omnipotent char", !496, i64 0}
!496 = !{!"Simple C/C++ TBAA"}
!497 = !DILocation(line: 448, column: 9, scope: !473)
!498 = !{!494, !494, i64 0}
!499 = !DILocation(line: 449, column: 5, scope: !473)
!500 = !DILocation(line: 449, column: 22, scope: !473)
!501 = !DILocalVariable(name: "ctx", arg: 1, scope: !502, file: !3, line: 152, type: !476)
!502 = distinct !DISubprogram(name: "parse_packet", scope: !3, file: !3, line: 152, type: !503, scopeLine: 152, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !505)
!503 = !DISubroutineType(types: !504)
!504 = !{!92, !476, !64}
!505 = !{!501, !506, !507, !508, !509, !522, !551, !573, !578, !579, !580, !581, !582, !583, !584, !585, !586, !587}
!506 = !DILocalVariable(name: "net_ev", arg: 2, scope: !502, file: !3, line: 152, type: !64)
!507 = !DILocalVariable(name: "data_end", scope: !502, file: !3, line: 153, type: !59)
!508 = !DILocalVariable(name: "data", scope: !502, file: !3, line: 154, type: !59)
!509 = !DILocalVariable(name: "eth", scope: !502, file: !3, line: 158, type: !510)
!510 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !511, size: 64)
!511 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !512, line: 168, size: 112, elements: !513)
!512 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!513 = !{!514, !518, !519}
!514 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !511, file: !512, line: 169, baseType: !515, size: 48)
!515 = !DICompositeType(tag: DW_TAG_array_type, baseType: !72, size: 48, elements: !516)
!516 = !{!517}
!517 = !DISubrange(count: 6)
!518 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !511, file: !512, line: 170, baseType: !515, size: 48, offset: 48)
!519 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !511, file: !512, line: 171, baseType: !520, size: 16, offset: 96)
!520 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !521, line: 25, baseType: !61)
!521 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!522 = !DILocalVariable(name: "iphdr", scope: !502, file: !3, line: 159, type: !523)
!523 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !524, size: 64)
!524 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !525, line: 87, size: 160, elements: !526)
!525 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "042b09a58768855e3578a0a8eba49be7")
!526 = !{!527, !528, !529, !530, !531, !532, !533, !534, !535, !537}
!527 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !524, file: !525, line: 89, baseType: !71, size: 4, flags: DIFlagBitField, extraData: i64 0)
!528 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !524, file: !525, line: 90, baseType: !71, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!529 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !524, file: !525, line: 97, baseType: !71, size: 8, offset: 8)
!530 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !524, file: !525, line: 98, baseType: !520, size: 16, offset: 16)
!531 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !524, file: !525, line: 99, baseType: !520, size: 16, offset: 32)
!532 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !524, file: !525, line: 100, baseType: !520, size: 16, offset: 48)
!533 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !524, file: !525, line: 101, baseType: !71, size: 8, offset: 64)
!534 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !524, file: !525, line: 102, baseType: !71, size: 8, offset: 72)
!535 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !524, file: !525, line: 103, baseType: !536, size: 16, offset: 80)
!536 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !521, line: 31, baseType: !61)
!537 = !DIDerivedType(tag: DW_TAG_member, scope: !524, file: !525, line: 104, baseType: !538, size: 64, offset: 96)
!538 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !524, file: !525, line: 104, size: 64, elements: !539)
!539 = !{!540, !546}
!540 = !DIDerivedType(tag: DW_TAG_member, scope: !538, file: !525, line: 104, baseType: !541, size: 64)
!541 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !538, file: !525, line: 104, size: 64, elements: !542)
!542 = !{!543, !545}
!543 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !541, file: !525, line: 104, baseType: !544, size: 32)
!544 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !521, line: 27, baseType: !114)
!545 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !541, file: !525, line: 104, baseType: !544, size: 32, offset: 32)
!546 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !538, file: !525, line: 104, baseType: !547, size: 64)
!547 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !538, file: !525, line: 104, size: 64, elements: !548)
!548 = !{!549, !550}
!549 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !547, file: !525, line: 104, baseType: !544, size: 32)
!550 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !547, file: !525, line: 104, baseType: !544, size: 32, offset: 32)
!551 = !DILocalVariable(name: "tcph", scope: !502, file: !3, line: 160, type: !552)
!552 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !553, size: 64)
!553 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !554, line: 25, size: 160, elements: !555)
!554 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "", checksumkind: CSK_MD5, checksum: "8d74bf2133e7b3dab885994b9916aa13")
!555 = !{!556, !557, !558, !559, !560, !561, !562, !563, !564, !565, !566, !567, !568, !569, !570, !571, !572}
!556 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !553, file: !554, line: 26, baseType: !520, size: 16)
!557 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !553, file: !554, line: 27, baseType: !520, size: 16, offset: 16)
!558 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !553, file: !554, line: 28, baseType: !544, size: 32, offset: 32)
!559 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !553, file: !554, line: 29, baseType: !544, size: 32, offset: 64)
!560 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !553, file: !554, line: 31, baseType: !61, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!561 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !553, file: !554, line: 32, baseType: !61, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!562 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !553, file: !554, line: 33, baseType: !61, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!563 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !553, file: !554, line: 34, baseType: !61, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!564 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !553, file: !554, line: 35, baseType: !61, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!565 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !553, file: !554, line: 36, baseType: !61, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!566 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !553, file: !554, line: 37, baseType: !61, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!567 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !553, file: !554, line: 38, baseType: !61, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!568 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !553, file: !554, line: 39, baseType: !61, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!569 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !553, file: !554, line: 40, baseType: !61, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!570 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !553, file: !554, line: 55, baseType: !520, size: 16, offset: 112)
!571 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !553, file: !554, line: 56, baseType: !536, size: 16, offset: 128)
!572 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !553, file: !554, line: 57, baseType: !520, size: 16, offset: 144)
!573 = !DILocalVariable(name: "nh", scope: !502, file: !3, line: 162, type: !574)
!574 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !575, line: 33, size: 64, elements: !576)
!575 = !DIFile(filename: "./../common/parsing_helpers.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/mtp", checksumkind: CSK_MD5, checksum: "172efdd203783aed49c0ce78645261a8")
!576 = !{!577}
!577 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !574, file: !575, line: 34, baseType: !59, size: 64)
!578 = !DILocalVariable(name: "eth_type", scope: !502, file: !3, line: 163, type: !92)
!579 = !DILocalVariable(name: "ip_type", scope: !502, file: !3, line: 163, type: !92)
!580 = !DILocalVariable(name: "saddr", scope: !502, file: !3, line: 194, type: !544)
!581 = !DILocalVariable(name: "src_ip", scope: !502, file: !3, line: 195, type: !71)
!582 = !DILocalVariable(name: "daddr", scope: !502, file: !3, line: 210, type: !544)
!583 = !DILocalVariable(name: "dst_ip", scope: !502, file: !3, line: 211, type: !71)
!584 = !DILocalVariable(name: "sport", scope: !502, file: !3, line: 236, type: !520)
!585 = !DILocalVariable(name: "src_port", scope: !502, file: !3, line: 237, type: !71)
!586 = !DILocalVariable(name: "dport", scope: !502, file: !3, line: 242, type: !520)
!587 = !DILocalVariable(name: "dst_port", scope: !502, file: !3, line: 243, type: !71)
!588 = !DILocation(line: 0, scope: !502, inlinedAt: !589)
!589 = distinct !DILocation(line: 451, column: 9, scope: !590)
!590 = distinct !DILexicalBlock(scope: !473, file: !3, line: 451, column: 8)
!591 = !DILocation(line: 153, column: 41, scope: !502, inlinedAt: !589)
!592 = !{!493, !494, i64 4}
!593 = !DILocation(line: 153, column: 30, scope: !502, inlinedAt: !589)
!594 = !DILocation(line: 153, column: 22, scope: !502, inlinedAt: !589)
!595 = !DILocation(line: 154, column: 41, scope: !502, inlinedAt: !589)
!596 = !{!493, !494, i64 0}
!597 = !DILocation(line: 154, column: 30, scope: !502, inlinedAt: !589)
!598 = !DILocation(line: 154, column: 22, scope: !502, inlinedAt: !589)
!599 = !DILocalVariable(name: "nh", arg: 1, scope: !600, file: !575, line: 124, type: !603)
!600 = distinct !DISubprogram(name: "parse_ethhdr", scope: !575, file: !575, line: 124, type: !601, scopeLine: 127, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !605)
!601 = !DISubroutineType(types: !602)
!602 = !{!92, !603, !59, !604}
!603 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !574, size: 64)
!604 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !510, size: 64)
!605 = !{!599, !606, !607}
!606 = !DILocalVariable(name: "data_end", arg: 2, scope: !600, file: !575, line: 125, type: !59)
!607 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !600, file: !575, line: 126, type: !604)
!608 = !DILocation(line: 0, scope: !600, inlinedAt: !609)
!609 = distinct !DILocation(line: 167, column: 16, scope: !502, inlinedAt: !589)
!610 = !DILocalVariable(name: "nh", arg: 1, scope: !611, file: !575, line: 79, type: !603)
!611 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !575, file: !575, line: 79, type: !612, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !619)
!612 = !DISubroutineType(types: !613)
!613 = !{!92, !603, !59, !604, !614}
!614 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !615, size: 64)
!615 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !575, line: 64, size: 32, elements: !616)
!616 = !{!617}
!617 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !615, file: !575, line: 65, baseType: !618, size: 32)
!618 = !DICompositeType(tag: DW_TAG_array_type, baseType: !61, size: 32, elements: !110)
!619 = !{!610, !620, !621, !622, !623, !624, !625, !631, !632}
!620 = !DILocalVariable(name: "data_end", arg: 2, scope: !611, file: !575, line: 80, type: !59)
!621 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !611, file: !575, line: 81, type: !604)
!622 = !DILocalVariable(name: "vlans", arg: 4, scope: !611, file: !575, line: 82, type: !614)
!623 = !DILocalVariable(name: "eth", scope: !611, file: !575, line: 84, type: !510)
!624 = !DILocalVariable(name: "hdrsize", scope: !611, file: !575, line: 85, type: !92)
!625 = !DILocalVariable(name: "vlh", scope: !611, file: !575, line: 86, type: !626)
!626 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !627, size: 64)
!627 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !575, line: 42, size: 32, elements: !628)
!628 = !{!629, !630}
!629 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !627, file: !575, line: 43, baseType: !520, size: 16)
!630 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !627, file: !575, line: 44, baseType: !520, size: 16, offset: 16)
!631 = !DILocalVariable(name: "h_proto", scope: !611, file: !575, line: 87, type: !61)
!632 = !DILocalVariable(name: "i", scope: !611, file: !575, line: 88, type: !92)
!633 = !DILocation(line: 0, scope: !611, inlinedAt: !634)
!634 = distinct !DILocation(line: 129, column: 9, scope: !600, inlinedAt: !609)
!635 = !DILocation(line: 93, column: 14, scope: !636, inlinedAt: !634)
!636 = distinct !DILexicalBlock(scope: !611, file: !575, line: 93, column: 6)
!637 = !DILocation(line: 93, column: 24, scope: !636, inlinedAt: !634)
!638 = !DILocation(line: 93, column: 6, scope: !611, inlinedAt: !634)
!639 = !DILocation(line: 99, column: 17, scope: !611, inlinedAt: !634)
!640 = !{!641, !641, i64 0}
!641 = !{!"short", !495, i64 0}
!642 = !DILocalVariable(name: "h_proto", arg: 1, scope: !643, file: !575, line: 68, type: !61)
!643 = distinct !DISubprogram(name: "proto_is_vlan", scope: !575, file: !575, line: 68, type: !644, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !646)
!644 = !DISubroutineType(types: !645)
!645 = !{!92, !61}
!646 = !{!642}
!647 = !DILocation(line: 0, scope: !643, inlinedAt: !648)
!648 = distinct !DILocation(line: 106, column: 8, scope: !649, inlinedAt: !634)
!649 = distinct !DILexicalBlock(scope: !650, file: !575, line: 106, column: 7)
!650 = distinct !DILexicalBlock(scope: !651, file: !575, line: 105, column: 39)
!651 = distinct !DILexicalBlock(scope: !652, file: !575, line: 105, column: 2)
!652 = distinct !DILexicalBlock(scope: !611, file: !575, line: 105, column: 2)
!653 = !DILocation(line: 70, column: 20, scope: !643, inlinedAt: !648)
!654 = !DILocation(line: 70, column: 46, scope: !643, inlinedAt: !648)
!655 = !DILocation(line: 106, column: 7, scope: !650, inlinedAt: !634)
!656 = !DILocation(line: 112, column: 18, scope: !650, inlinedAt: !634)
!657 = !DILocation(line: 168, column: 18, scope: !658, inlinedAt: !589)
!658 = distinct !DILexicalBlock(scope: !502, file: !3, line: 168, column: 9)
!659 = !DILocation(line: 168, column: 9, scope: !502, inlinedAt: !589)
!660 = !DILocalVariable(name: "nh", arg: 1, scope: !661, file: !575, line: 151, type: !603)
!661 = distinct !DISubprogram(name: "parse_iphdr", scope: !575, file: !575, line: 151, type: !662, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !665)
!662 = !DISubroutineType(types: !663)
!663 = !{!92, !603, !59, !664}
!664 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !523, size: 64)
!665 = !{!660, !666, !667, !668, !669}
!666 = !DILocalVariable(name: "data_end", arg: 2, scope: !661, file: !575, line: 152, type: !59)
!667 = !DILocalVariable(name: "iphdr", arg: 3, scope: !661, file: !575, line: 153, type: !664)
!668 = !DILocalVariable(name: "iph", scope: !661, file: !575, line: 155, type: !523)
!669 = !DILocalVariable(name: "hdrsize", scope: !661, file: !575, line: 156, type: !92)
!670 = !DILocation(line: 0, scope: !661, inlinedAt: !671)
!671 = distinct !DILocation(line: 185, column: 15, scope: !502, inlinedAt: !589)
!672 = !DILocation(line: 161, column: 17, scope: !661, inlinedAt: !671)
!673 = !DILocation(line: 161, column: 21, scope: !661, inlinedAt: !671)
!674 = !DILocation(line: 163, column: 13, scope: !675, inlinedAt: !671)
!675 = distinct !DILexicalBlock(scope: !661, file: !575, line: 163, column: 5)
!676 = !DILocation(line: 163, column: 5, scope: !661, inlinedAt: !671)
!677 = !DILocation(line: 167, column: 14, scope: !678, inlinedAt: !671)
!678 = distinct !DILexicalBlock(scope: !661, file: !575, line: 167, column: 6)
!679 = !DILocation(line: 167, column: 24, scope: !678, inlinedAt: !671)
!680 = !DILocation(line: 167, column: 6, scope: !661, inlinedAt: !671)
!681 = !DILocation(line: 173, column: 14, scope: !661, inlinedAt: !671)
!682 = !{!683, !495, i64 9}
!683 = !{!"iphdr", !495, i64 0, !495, i64 0, !495, i64 1, !641, i64 2, !641, i64 4, !641, i64 6, !495, i64 8, !495, i64 9, !641, i64 10, !495, i64 12}
!684 = !DILocation(line: 189, column: 16, scope: !685, inlinedAt: !589)
!685 = distinct !DILexicalBlock(scope: !502, file: !3, line: 189, column: 8)
!686 = !DILocation(line: 189, column: 8, scope: !502, inlinedAt: !589)
!687 = !DILocation(line: 194, column: 27, scope: !502, inlinedAt: !589)
!688 = !{!495, !495, i64 0}
!689 = !DILocation(line: 197, column: 22, scope: !502, inlinedAt: !589)
!690 = !DILocation(line: 198, column: 22, scope: !502, inlinedAt: !589)
!691 = !DILocation(line: 199, column: 22, scope: !502, inlinedAt: !589)
!692 = !DILocation(line: 199, column: 37, scope: !502, inlinedAt: !589)
!693 = !DILocation(line: 199, column: 14, scope: !502, inlinedAt: !589)
!694 = !DILocation(line: 200, column: 31, scope: !502, inlinedAt: !589)
!695 = !{!696, !495, i64 0}
!696 = !{!"net_event", !697, i64 0, !698, i64 8}
!697 = !{!"flow_id", !495, i64 0, !495, i64 1, !495, i64 2, !495, i64 3}
!698 = !{!"long long", !495, i64 0}
!699 = !DILocation(line: 210, column: 27, scope: !502, inlinedAt: !589)
!700 = !DILocation(line: 213, column: 22, scope: !502, inlinedAt: !589)
!701 = !DILocation(line: 214, column: 22, scope: !502, inlinedAt: !589)
!702 = !DILocation(line: 215, column: 22, scope: !502, inlinedAt: !589)
!703 = !DILocation(line: 215, column: 37, scope: !502, inlinedAt: !589)
!704 = !DILocation(line: 215, column: 14, scope: !502, inlinedAt: !589)
!705 = !DILocation(line: 216, column: 24, scope: !502, inlinedAt: !589)
!706 = !DILocation(line: 216, column: 32, scope: !502, inlinedAt: !589)
!707 = !{!696, !495, i64 2}
!708 = !DILocalVariable(name: "nh", arg: 1, scope: !709, file: !575, line: 247, type: !603)
!709 = distinct !DISubprogram(name: "parse_tcphdr", scope: !575, file: !575, line: 247, type: !710, scopeLine: 250, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !713)
!710 = !DISubroutineType(types: !711)
!711 = !{!92, !603, !59, !712}
!712 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !552, size: 64)
!713 = !{!708, !714, !715, !716, !717}
!714 = !DILocalVariable(name: "data_end", arg: 2, scope: !709, file: !575, line: 248, type: !59)
!715 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !709, file: !575, line: 249, type: !712)
!716 = !DILocalVariable(name: "len", scope: !709, file: !575, line: 251, type: !92)
!717 = !DILocalVariable(name: "h", scope: !709, file: !575, line: 252, type: !552)
!718 = !DILocation(line: 0, scope: !709, inlinedAt: !719)
!719 = distinct !DILocation(line: 231, column: 8, scope: !720, inlinedAt: !589)
!720 = distinct !DILexicalBlock(scope: !502, file: !3, line: 231, column: 8)
!721 = !DILocation(line: 254, column: 8, scope: !722, inlinedAt: !719)
!722 = distinct !DILexicalBlock(scope: !709, file: !575, line: 254, column: 6)
!723 = !DILocation(line: 254, column: 12, scope: !722, inlinedAt: !719)
!724 = !DILocation(line: 254, column: 6, scope: !709, inlinedAt: !719)
!725 = !DILocation(line: 257, column: 11, scope: !709, inlinedAt: !719)
!726 = !DILocation(line: 257, column: 16, scope: !709, inlinedAt: !719)
!727 = !DILocation(line: 259, column: 9, scope: !728, inlinedAt: !719)
!728 = distinct !DILexicalBlock(scope: !709, file: !575, line: 259, column: 5)
!729 = !DILocation(line: 259, column: 5, scope: !709, inlinedAt: !719)
!730 = !DILocation(line: 263, column: 14, scope: !731, inlinedAt: !719)
!731 = distinct !DILexicalBlock(scope: !709, file: !575, line: 263, column: 6)
!732 = !DILocation(line: 263, column: 20, scope: !731, inlinedAt: !719)
!733 = !DILocation(line: 263, column: 6, scope: !709, inlinedAt: !719)
!734 = !DILocation(line: 236, column: 20, scope: !502, inlinedAt: !589)
!735 = !{!736, !641, i64 0}
!736 = !{!"tcphdr", !641, i64 0, !641, i64 2, !494, i64 4, !494, i64 8, !641, i64 12, !641, i64 12, !641, i64 13, !641, i64 13, !641, i64 13, !641, i64 13, !641, i64 13, !641, i64 13, !641, i64 13, !641, i64 13, !641, i64 14, !641, i64 16, !641, i64 18}
!737 = !DILocation(line: 239, column: 38, scope: !502, inlinedAt: !589)
!738 = !DILocation(line: 239, column: 16, scope: !502, inlinedAt: !589)
!739 = !DILocation(line: 240, column: 24, scope: !502, inlinedAt: !589)
!740 = !DILocation(line: 240, column: 33, scope: !502, inlinedAt: !589)
!741 = !{!696, !495, i64 1}
!742 = !DILocation(line: 242, column: 20, scope: !502, inlinedAt: !589)
!743 = !{!736, !641, i64 2}
!744 = !DILocation(line: 245, column: 38, scope: !502, inlinedAt: !589)
!745 = !DILocation(line: 245, column: 16, scope: !502, inlinedAt: !589)
!746 = !DILocation(line: 246, column: 24, scope: !502, inlinedAt: !589)
!747 = !DILocation(line: 246, column: 34, scope: !502, inlinedAt: !589)
!748 = !{!696, !495, i64 3}
!749 = !DILocalVariable(name: "event", arg: 1, scope: !750, file: !3, line: 435, type: !59)
!750 = distinct !DISubprogram(name: "scheduler", scope: !3, file: !3, line: 435, type: !751, scopeLine: 435, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !753)
!751 = !DISubroutineType(types: !752)
!752 = !{null, !59, !14, !476}
!753 = !{!749, !754, !755}
!754 = !DILocalVariable(name: "type", arg: 2, scope: !750, file: !3, line: 435, type: !14)
!755 = !DILocalVariable(name: "ctx", arg: 3, scope: !750, file: !3, line: 435, type: !476)
!756 = !DILocation(line: 0, scope: !750, inlinedAt: !757)
!757 = distinct !DILocation(line: 454, column: 5, scope: !473)
!758 = !DILocation(line: 0, scope: !383, inlinedAt: !759)
!759 = distinct !DILocation(line: 436, column: 5, scope: !750, inlinedAt: !757)
!760 = !DILocation(line: 401, column: 9, scope: !761, inlinedAt: !759)
!761 = distinct !DILexicalBlock(scope: !390, file: !3, line: 401, column: 9)
!762 = !DILocation(line: 402, column: 38, scope: !390, inlinedAt: !759)
!763 = !{i64 0, i64 1, !688, i64 1, i64 1, !688, i64 2, i64 1, !688, i64 3, i64 1, !688, i64 8, i64 8, !764}
!764 = !{!698, !698, i64 0}
!765 = !DILocation(line: 0, scope: !390, inlinedAt: !759)
!766 = !DILocalVariable(name: "ev_flow_id", arg: 1, scope: !767, file: !3, line: 307, type: !68)
!767 = distinct !DISubprogram(name: "find_head_tail", scope: !3, file: !3, line: 307, type: !768, scopeLine: 307, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !771)
!768 = !DISubroutineType(types: !769)
!769 = !{!92, !68, !770}
!770 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !259, size: 64)
!771 = !{!766, !772, !773}
!772 = !DILocalVariable(name: "ht_info", arg: 2, scope: !767, file: !3, line: 307, type: !770)
!773 = !DILocalVariable(name: "new_ht_info", scope: !774, file: !3, line: 310, type: !260)
!774 = distinct !DILexicalBlock(scope: !775, file: !3, line: 309, column: 21)
!775 = distinct !DILexicalBlock(scope: !767, file: !3, line: 309, column: 8)
!776 = !DILocation(line: 307, column: 58, scope: !767, inlinedAt: !777)
!777 = distinct !DILocation(line: 404, column: 9, scope: !390, inlinedAt: !759)
!778 = !DILocation(line: 0, scope: !767, inlinedAt: !777)
!779 = !DILocation(line: 308, column: 16, scope: !767, inlinedAt: !777)
!780 = !DILocation(line: 309, column: 9, scope: !775, inlinedAt: !777)
!781 = !DILocation(line: 309, column: 8, scope: !767, inlinedAt: !777)
!782 = !DILocation(line: 319, column: 1, scope: !767, inlinedAt: !777)
!783 = !DILocation(line: 405, column: 12, scope: !390, inlinedAt: !759)
!784 = !DILocation(line: 310, column: 9, scope: !774, inlinedAt: !777)
!785 = !DILocation(line: 310, column: 32, scope: !774, inlinedAt: !777)
!786 = !DILocation(line: 311, column: 9, scope: !774, inlinedAt: !777)
!787 = !DILocation(line: 313, column: 20, scope: !774, inlinedAt: !777)
!788 = !DILocation(line: 316, column: 5, scope: !775, inlinedAt: !777)
!789 = !DILocation(line: 405, column: 13, scope: !790, inlinedAt: !759)
!790 = distinct !DILexicalBlock(scope: !390, file: !3, line: 405, column: 12)
!791 = !DILocation(line: 408, column: 107, scope: !792, inlinedAt: !759)
!792 = distinct !DILexicalBlock(scope: !390, file: !3, line: 408, column: 12)
!793 = !DILocation(line: 0, scope: !433, inlinedAt: !794)
!794 = distinct !DILocation(line: 408, column: 13, scope: !792, inlinedAt: !759)
!795 = !DILocation(line: 362, column: 9, scope: !796, inlinedAt: !794)
!796 = distinct !DILexicalBlock(scope: !433, file: !3, line: 362, column: 8)
!797 = !DILocation(line: 362, column: 15, scope: !796, inlinedAt: !794)
!798 = !DILocation(line: 0, scope: !796, inlinedAt: !794)
!799 = !DILocation(line: 362, column: 20, scope: !796, inlinedAt: !794)
!800 = !DILocation(line: 364, column: 9, scope: !801, inlinedAt: !794)
!801 = distinct !DILexicalBlock(scope: !802, file: !3, line: 364, column: 9)
!802 = distinct !DILexicalBlock(scope: !796, file: !3, line: 363, column: 29)
!803 = !DILocation(line: 408, column: 12, scope: !390, inlinedAt: !759)
!804 = !DILocation(line: 371, column: 5, scope: !433, inlinedAt: !794)
!805 = !DILocation(line: 371, column: 20, scope: !433, inlinedAt: !794)
!806 = !DILocation(line: 372, column: 43, scope: !433, inlinedAt: !794)
!807 = !DILocation(line: 373, column: 9, scope: !808, inlinedAt: !794)
!808 = distinct !DILexicalBlock(scope: !433, file: !3, line: 373, column: 8)
!809 = !DILocation(line: 373, column: 8, scope: !433, inlinedAt: !794)
!810 = !DILocation(line: 374, column: 9, scope: !811, inlinedAt: !794)
!811 = distinct !DILexicalBlock(scope: !812, file: !3, line: 374, column: 9)
!812 = distinct !DILexicalBlock(scope: !808, file: !3, line: 373, column: 22)
!813 = !DILocation(line: 375, column: 9, scope: !812, inlinedAt: !794)
!814 = !DILocation(line: 378, column: 8, scope: !815, inlinedAt: !794)
!815 = distinct !DILexicalBlock(scope: !433, file: !3, line: 378, column: 8)
!816 = !DILocation(line: 378, column: 8, scope: !433, inlinedAt: !794)
!817 = !DILocation(line: 379, column: 9, scope: !818, inlinedAt: !794)
!818 = distinct !DILexicalBlock(scope: !819, file: !3, line: 379, column: 9)
!819 = distinct !DILexicalBlock(scope: !815, file: !3, line: 378, column: 64)
!820 = !DILocation(line: 380, column: 9, scope: !819, inlinedAt: !794)
!821 = !DILocation(line: 394, column: 1, scope: !433, inlinedAt: !794)
!822 = !DILocation(line: 388, column: 8, scope: !823, inlinedAt: !794)
!823 = distinct !DILexicalBlock(scope: !433, file: !3, line: 388, column: 8)
!824 = !DILocation(line: 388, column: 14, scope: !823, inlinedAt: !794)
!825 = !DILocation(line: 388, column: 8, scope: !433, inlinedAt: !794)
!826 = !DILocation(line: 0, scope: !823, inlinedAt: !794)
!827 = !DILocation(line: 409, column: 13, scope: !828, inlinedAt: !759)
!828 = distinct !DILexicalBlock(scope: !829, file: !3, line: 409, column: 13)
!829 = distinct !DILexicalBlock(scope: !792, file: !3, line: 408, column: 119)
!830 = !DILocation(line: 410, column: 9, scope: !829, inlinedAt: !759)
!831 = !DILocation(line: 464, column: 9, scope: !832)
!832 = distinct !DILexicalBlock(scope: !473, file: !3, line: 464, column: 9)
!833 = !DILocation(line: 464, column: 9, scope: !473)
!834 = !DILocation(line: 466, column: 44, scope: !835)
!835 = distinct !DILexicalBlock(scope: !832, file: !3, line: 464, column: 58)
!836 = !DILocation(line: 466, column: 16, scope: !835)
!837 = !DILocation(line: 466, column: 9, scope: !835)
!838 = !DILocation(line: 469, column: 1, scope: !473)
