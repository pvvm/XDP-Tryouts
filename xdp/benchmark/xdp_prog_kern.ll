; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.inner_map_array = type { ptr, ptr, ptr, ptr }
%struct.inner_map_queue = type { ptr, ptr, ptr }
%struct.inner_array_hash = type { ptr, ptr, ptr, ptr }
%struct.anon.1 = type { ptr, ptr, ptr, ptr }
%struct.anon.2 = type { ptr, ptr, ptr, ptr }
%struct.anon.3 = type { ptr, ptr, ptr, ptr }
%struct.anon.4 = type { ptr, ptr, ptr, ptr }
%struct.anon.5 = type { ptr, ptr, ptr, ptr }
%struct.anon.6 = type { ptr, ptr, ptr, ptr }
%struct.map_locked_value = type { i64, %struct.bpf_spin_lock }
%struct.bpf_spin_lock = type { i32 }
%struct.hash_key = type { i32 }

@inner_map_array0 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !0
@inner_map_array1 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !280
@inner_map_array2 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !282
@inner_map_array3 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !284
@inner_map_array4 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !286
@inner_map_array5 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !288
@inner_map_array6 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !290
@inner_map_array7 = dso_local global %struct.inner_map_array zeroinitializer, section ".maps", align 8, !dbg !292
@outer_map_array = dso_local global { ptr, ptr, ptr, [8 x ptr] } { ptr null, ptr null, ptr null, [8 x ptr] [ptr @inner_map_array0, ptr @inner_map_array1, ptr @inner_map_array2, ptr @inner_map_array3, ptr @inner_map_array4, ptr @inner_map_array5, ptr @inner_map_array6, ptr @inner_map_array7] }, section ".maps", align 8, !dbg !21
@inner_map_queue0 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !294
@inner_map_queue1 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !296
@inner_map_queue2 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !298
@inner_map_queue3 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !300
@inner_map_queue4 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !302
@inner_map_queue5 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !304
@inner_map_queue6 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !306
@inner_map_queue7 = dso_local global %struct.inner_map_queue zeroinitializer, section ".maps", align 8, !dbg !308
@outer_map_queue = dso_local global { ptr, ptr, ptr, [8 x ptr] } { ptr null, ptr null, ptr null, [8 x ptr] [ptr @inner_map_queue0, ptr @inner_map_queue1, ptr @inner_map_queue2, ptr @inner_map_queue3, ptr @inner_map_queue4, ptr @inner_map_queue5, ptr @inner_map_queue6, ptr @inner_map_queue7] }, section ".maps", align 8, !dbg !58
@inner_array_hash0 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !358
@inner_array_hash1 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !360
@inner_array_hash2 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !362
@inner_array_hash3 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !364
@inner_array_hash4 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !366
@inner_array_hash5 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !368
@inner_array_hash6 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !370
@inner_array_hash7 = dso_local global %struct.inner_array_hash zeroinitializer, section ".maps", align 8, !dbg !372
@outer_map_hash = dso_local global { ptr, ptr, ptr, [8 x ptr] } { ptr null, ptr null, ptr null, [8 x ptr] [ptr @inner_array_hash0, ptr @inner_array_hash1, ptr @inner_array_hash2, ptr @inner_array_hash3, ptr @inner_array_hash4, ptr @inner_array_hash5, ptr @inner_array_hash6, ptr @inner_array_hash7] }, section ".maps", align 8, !dbg !81
@common_array_lookup_diff_keys.____fmt = internal constant [35 x i8] c"Error while looking up counter map\00", align 1, !dbg !109
@common_array = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !310
@common_array_lookup_diff_keys.____fmt.1 = internal constant [33 x i8] c"Error while looking up timer map\00", align 1, !dbg !135
@percpu_array_lookup.____fmt = internal constant [35 x i8] c"Error while looking up counter map\00", align 1, !dbg !140
@percpu_array = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !318
@percpu_array_lookup.____fmt.2 = internal constant [33 x i8] c"Error while looking up timer map\00", align 1, !dbg !150
@common_array_lookup_same_keys.____fmt = internal constant [36 x i8] c"Error while looking up counter map\0A\00", align 1, !dbg !152
@common_array_lookup_same_keys.____fmt.3 = internal constant [34 x i8] c"Error while looking up timer map\0A\00", align 1, !dbg !165
@simply_drop.____fmt = internal constant [36 x i8] c"Error while looking up counter map\0A\00", align 1, !dbg !170
@simply_drop.____fmt.4 = internal constant [34 x i8] c"Error while looking up timer map\0A\00", align 1, !dbg !178
@map_of_maps_queue.____fmt = internal constant [36 x i8] c"Error while looking up counter map\0A\00", align 1, !dbg !180
@map_of_maps_queue.____fmt.5 = internal constant [34 x i8] c"Error while looking up timer map\0A\00", align 1, !dbg !191
@map_of_maps_array.____fmt = internal constant [36 x i8] c"Error while looking up counter map\0A\00", align 1, !dbg !193
@map_of_maps_array.____fmt.6 = internal constant [34 x i8] c"Error while looking up timer map\0A\00", align 1, !dbg !203
@gets_cpu_id.____fmt = internal constant [36 x i8] c"Error while looking up counter map\0A\00", align 1, !dbg !205
@gets_cpu_id.____fmt.7 = internal constant [34 x i8] c"Error while looking up timer map\0A\00", align 1, !dbg !215
@lock_map.____fmt = internal constant [36 x i8] c"Error while looking up counter map\0A\00", align 1, !dbg !217
@lock_map.____fmt.8 = internal constant [34 x i8] c"Error while looking up timer map\0A\00", align 1, !dbg !227
@map_of_maps_hash.____fmt = internal constant [36 x i8] c"Error while looking up counter map\0A\00", align 1, !dbg !229
@map_of_maps_hash.____fmt.9 = internal constant [34 x i8] c"Error while looking up timer map\0A\00", align 1, !dbg !237
@common_hash_map.____fmt = internal constant [35 x i8] c"Error while looking up counter map\00", align 1, !dbg !239
@common_hash = dso_local global %struct.anon.3 zeroinitializer, section ".maps", align 8, !dbg !346
@common_hash_map.____fmt.10 = internal constant [40 x i8] c"Error while getting entry from hash map\00", align 1, !dbg !252
@common_hash_map.____fmt.11 = internal constant [33 x i8] c"Error while looking up timer map\00", align 1, !dbg !257
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !259
@lock_array = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !264
@counter_array = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !330
@time_array = dso_local global %struct.anon.6 zeroinitializer, section ".maps", align 8, !dbg !338
@lookup_map_of_maps_queue.____fmt = internal constant [35 x i8] c"Error while accessing map of maps\0A\00", align 1, !dbg !392
@lookup_map_of_maps_queue.____fmt.12 = internal constant [40 x i8] c"Error while reading element from queue\0A\00", align 1, !dbg !402
@lookup_map_of_maps_queue.____fmt.13 = internal constant [38 x i8] c"Error while pushing element to queue\0A\00", align 1, !dbg !404
@lookup_map_of_maps_array.____fmt = internal constant [35 x i8] c"Error while accessing map of maps\0A\00", align 1, !dbg !422
@lookup_lock_map.____fmt = internal constant [36 x i8] c"Error while accessing locked entry\0A\00", align 1, !dbg !432
@lookup_map_of_maps_hash.____fmt = internal constant [35 x i8] c"Error while accessing map of maps\0A\00", align 1, !dbg !446
@lookup_map_of_maps_hash.____fmt.14 = internal constant [32 x i8] c"Couldn't get entry of inner map\00", align 1, !dbg !456
@llvm.compiler.used = appending global [44 x ptr] [ptr @_license, ptr @common_array, ptr @common_array_lookup_diff_keys, ptr @common_array_lookup_same_keys, ptr @common_hash, ptr @common_hash_map, ptr @counter_array, ptr @gets_cpu_id, ptr @inner_array_hash0, ptr @inner_array_hash1, ptr @inner_array_hash2, ptr @inner_array_hash3, ptr @inner_array_hash4, ptr @inner_array_hash5, ptr @inner_array_hash6, ptr @inner_array_hash7, ptr @inner_map_array0, ptr @inner_map_array1, ptr @inner_map_array2, ptr @inner_map_array3, ptr @inner_map_array4, ptr @inner_map_array5, ptr @inner_map_array6, ptr @inner_map_array7, ptr @inner_map_queue0, ptr @inner_map_queue1, ptr @inner_map_queue2, ptr @inner_map_queue3, ptr @inner_map_queue4, ptr @inner_map_queue5, ptr @inner_map_queue6, ptr @inner_map_queue7, ptr @lock_array, ptr @lock_map, ptr @map_of_maps_array, ptr @map_of_maps_hash, ptr @map_of_maps_queue, ptr @outer_map_array, ptr @outer_map_hash, ptr @outer_map_queue, ptr @percpu_array, ptr @percpu_array_lookup, ptr @simply_drop, ptr @time_array], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @common_array_lookup_diff_keys(ptr nocapture readnone %0) #0 section "xdp" !dbg !111 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !124, metadata !DIExpression()), !dbg !474
  %7 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !475
  call void @llvm.dbg.value(metadata i32 %7, metadata !125, metadata !DIExpression()), !dbg !474
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5), !dbg !476
  call void @llvm.dbg.value(metadata i32 %7, metadata !481, metadata !DIExpression()), !dbg !476
  store i32 %7, ptr %5, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !476
  %8 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5) #4, !dbg !490
  call void @llvm.dbg.value(metadata ptr %8, metadata !482, metadata !DIExpression()), !dbg !476
  %9 = icmp eq ptr %8, null, !dbg !491
  br i1 %9, label %10, label %11, !dbg !493

10:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !494
  br label %17, !dbg !495

11:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %6) #4, !dbg !496
  %12 = load i64, ptr %8, align 8, !dbg !497, !tbaa !498
  %13 = add i64 %12, 1, !dbg !500
  call void @llvm.dbg.value(metadata i64 %13, metadata !483, metadata !DIExpression()), !dbg !476
  store i64 %13, ptr %6, align 8, !dbg !501, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !476
  call void @llvm.dbg.value(metadata ptr %6, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !476
  %14 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5, ptr noundef nonnull %6, i64 noundef 0) #4, !dbg !502
  %15 = load i64, ptr %6, align 8, !dbg !503, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %15, metadata !483, metadata !DIExpression()), !dbg !476
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %6) #4, !dbg !494
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !494
  %16 = icmp eq i64 %15, 0, !dbg !504
  br i1 %16, label %17, label %19, !dbg !495

17:                                               ; preds = %10, %11
  %18 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @common_array_lookup_diff_keys.____fmt, i32 noundef 35) #4, !dbg !505
  br label %19, !dbg !508

19:                                               ; preds = %17, %11
  %20 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !509
  call void @llvm.dbg.value(metadata i64 %20, metadata !126, metadata !DIExpression()), !dbg !474
  call void @llvm.dbg.value(metadata i32 0, metadata !127, metadata !DIExpression()), !dbg !510
  br label %30, !dbg !511

21:                                               ; preds = %37
  %22 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !512
  call void @llvm.dbg.value(metadata i64 %22, metadata !129, metadata !DIExpression()), !dbg !474
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3), !dbg !513
  call void @llvm.dbg.value(metadata i64 %20, metadata !518, metadata !DIExpression()), !dbg !513
  call void @llvm.dbg.value(metadata i64 %22, metadata !519, metadata !DIExpression()), !dbg !513
  call void @llvm.dbg.value(metadata i32 %7, metadata !520, metadata !DIExpression()), !dbg !513
  store i32 %7, ptr %3, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !513
  %23 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3) #4, !dbg !525
  call void @llvm.dbg.value(metadata ptr %23, metadata !521, metadata !DIExpression()), !dbg !513
  %24 = icmp eq ptr %23, null, !dbg !526
  br i1 %24, label %40, label %25, !dbg !528

25:                                               ; preds = %21
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #4, !dbg !529
  %26 = load i64, ptr %23, align 8, !dbg !530, !tbaa !498
  %27 = sub i64 %22, %20, !dbg !531
  %28 = add i64 %27, %26, !dbg !532
  call void @llvm.dbg.value(metadata i64 %28, metadata !522, metadata !DIExpression()), !dbg !513
  store i64 %28, ptr %4, align 8, !dbg !533, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !513
  call void @llvm.dbg.value(metadata ptr %4, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !513
  %29 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3, ptr noundef nonnull %4, i64 noundef 0) #4, !dbg !534
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #4, !dbg !535
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !535
  br label %42, !dbg !536

30:                                               ; preds = %19, %37
  %31 = phi i32 [ 0, %19 ], [ %38, %37 ]
  call void @llvm.dbg.value(metadata i32 %31, metadata !127, metadata !DIExpression()), !dbg !510
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !537
  call void @llvm.dbg.value(metadata i32 %7, metadata !542, metadata !DIExpression()), !dbg !537
  store i32 %7, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr @common_array, metadata !543, metadata !DIExpression()), !dbg !537
  call void @llvm.dbg.value(metadata ptr %2, metadata !542, metadata !DIExpression(DW_OP_deref)), !dbg !537
  %32 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @common_array, ptr noundef nonnull %2) #4, !dbg !547
  call void @llvm.dbg.value(metadata ptr %32, metadata !544, metadata !DIExpression()), !dbg !537
  %33 = icmp eq ptr %32, null, !dbg !548
  br i1 %33, label %37, label %34, !dbg !550

34:                                               ; preds = %30
  %35 = load i64, ptr %32, align 8, !dbg !551, !tbaa !498
  %36 = add i64 %35, 1, !dbg !551
  store i64 %36, ptr %32, align 8, !dbg !551, !tbaa !498
  br label %37, !dbg !552

37:                                               ; preds = %30, %34
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !553
  %38 = add nuw nsw i32 %31, 1, !dbg !554
  call void @llvm.dbg.value(metadata i32 %38, metadata !127, metadata !DIExpression()), !dbg !510
  %39 = icmp eq i32 %38, 100, !dbg !555
  br i1 %39, label %21, label %30, !dbg !511, !llvm.loop !556

40:                                               ; preds = %21
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !535
  %41 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @common_array_lookup_diff_keys.____fmt.1, i32 noundef 33) #4, !dbg !559
  br label %42, !dbg !562

42:                                               ; preds = %25, %40
  ret i32 1, !dbg !563
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind
define dso_local i32 @percpu_array_lookup(ptr nocapture readnone %0) #0 section "xdp" !dbg !142 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !144, metadata !DIExpression()), !dbg !564
  %7 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !565
  call void @llvm.dbg.value(metadata i32 %7, metadata !145, metadata !DIExpression()), !dbg !564
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5), !dbg !566
  call void @llvm.dbg.value(metadata i32 %7, metadata !481, metadata !DIExpression()), !dbg !566
  store i32 %7, ptr %5, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !566
  %8 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5) #4, !dbg !569
  call void @llvm.dbg.value(metadata ptr %8, metadata !482, metadata !DIExpression()), !dbg !566
  %9 = icmp eq ptr %8, null, !dbg !570
  br i1 %9, label %10, label %11, !dbg !571

10:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !572
  br label %17, !dbg !573

11:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %6) #4, !dbg !574
  %12 = load i64, ptr %8, align 8, !dbg !575, !tbaa !498
  %13 = add i64 %12, 1, !dbg !576
  call void @llvm.dbg.value(metadata i64 %13, metadata !483, metadata !DIExpression()), !dbg !566
  store i64 %13, ptr %6, align 8, !dbg !577, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !566
  call void @llvm.dbg.value(metadata ptr %6, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !566
  %14 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5, ptr noundef nonnull %6, i64 noundef 0) #4, !dbg !578
  %15 = load i64, ptr %6, align 8, !dbg !579, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %15, metadata !483, metadata !DIExpression()), !dbg !566
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %6) #4, !dbg !572
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !572
  %16 = icmp eq i64 %15, 0, !dbg !580
  br i1 %16, label %17, label %19, !dbg !573

17:                                               ; preds = %10, %11
  %18 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @percpu_array_lookup.____fmt, i32 noundef 35) #4, !dbg !581
  br label %19, !dbg !584

19:                                               ; preds = %17, %11
  %20 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !585
  call void @llvm.dbg.value(metadata i64 %20, metadata !146, metadata !DIExpression()), !dbg !564
  call void @llvm.dbg.value(metadata i32 0, metadata !147, metadata !DIExpression()), !dbg !586
  br label %30, !dbg !587

21:                                               ; preds = %37
  %22 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !588
  call void @llvm.dbg.value(metadata i64 %22, metadata !149, metadata !DIExpression()), !dbg !564
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3), !dbg !589
  call void @llvm.dbg.value(metadata i64 %20, metadata !518, metadata !DIExpression()), !dbg !589
  call void @llvm.dbg.value(metadata i64 %22, metadata !519, metadata !DIExpression()), !dbg !589
  call void @llvm.dbg.value(metadata i32 %7, metadata !520, metadata !DIExpression()), !dbg !589
  store i32 %7, ptr %3, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !589
  %23 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3) #4, !dbg !592
  call void @llvm.dbg.value(metadata ptr %23, metadata !521, metadata !DIExpression()), !dbg !589
  %24 = icmp eq ptr %23, null, !dbg !593
  br i1 %24, label %40, label %25, !dbg !594

25:                                               ; preds = %21
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #4, !dbg !595
  %26 = load i64, ptr %23, align 8, !dbg !596, !tbaa !498
  %27 = sub i64 %22, %20, !dbg !597
  %28 = add i64 %27, %26, !dbg !598
  call void @llvm.dbg.value(metadata i64 %28, metadata !522, metadata !DIExpression()), !dbg !589
  store i64 %28, ptr %4, align 8, !dbg !599, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !589
  call void @llvm.dbg.value(metadata ptr %4, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !589
  %29 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3, ptr noundef nonnull %4, i64 noundef 0) #4, !dbg !600
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #4, !dbg !601
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !601
  br label %42, !dbg !602

30:                                               ; preds = %19, %37
  %31 = phi i32 [ 0, %19 ], [ %38, %37 ]
  call void @llvm.dbg.value(metadata i32 %31, metadata !147, metadata !DIExpression()), !dbg !586
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !603
  call void @llvm.dbg.value(metadata i32 0, metadata !542, metadata !DIExpression()), !dbg !603
  store i32 0, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr @percpu_array, metadata !543, metadata !DIExpression()), !dbg !603
  call void @llvm.dbg.value(metadata ptr %2, metadata !542, metadata !DIExpression(DW_OP_deref)), !dbg !603
  %32 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @percpu_array, ptr noundef nonnull %2) #4, !dbg !606
  call void @llvm.dbg.value(metadata ptr %32, metadata !544, metadata !DIExpression()), !dbg !603
  %33 = icmp eq ptr %32, null, !dbg !607
  br i1 %33, label %37, label %34, !dbg !608

34:                                               ; preds = %30
  %35 = load i64, ptr %32, align 8, !dbg !609, !tbaa !498
  %36 = add i64 %35, 1, !dbg !609
  store i64 %36, ptr %32, align 8, !dbg !609, !tbaa !498
  br label %37, !dbg !610

37:                                               ; preds = %30, %34
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !611
  %38 = add nuw nsw i32 %31, 1, !dbg !612
  call void @llvm.dbg.value(metadata i32 %38, metadata !147, metadata !DIExpression()), !dbg !586
  %39 = icmp eq i32 %38, 100, !dbg !613
  br i1 %39, label %21, label %30, !dbg !587, !llvm.loop !614

40:                                               ; preds = %21
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !601
  %41 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @percpu_array_lookup.____fmt.2, i32 noundef 33) #4, !dbg !616
  br label %42, !dbg !619

42:                                               ; preds = %25, %40
  ret i32 1, !dbg !620
}

; Function Attrs: nounwind
define dso_local i32 @common_array_lookup_same_keys(ptr nocapture readnone %0) #0 section "xdp" !dbg !154 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !156, metadata !DIExpression()), !dbg !621
  %7 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !622
  call void @llvm.dbg.value(metadata i32 %7, metadata !157, metadata !DIExpression()), !dbg !621
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5), !dbg !623
  call void @llvm.dbg.value(metadata i32 %7, metadata !481, metadata !DIExpression()), !dbg !623
  store i32 %7, ptr %5, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !623
  %8 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5) #4, !dbg !626
  call void @llvm.dbg.value(metadata ptr %8, metadata !482, metadata !DIExpression()), !dbg !623
  %9 = icmp eq ptr %8, null, !dbg !627
  br i1 %9, label %10, label %11, !dbg !628

10:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !629
  br label %17, !dbg !630

11:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %6) #4, !dbg !631
  %12 = load i64, ptr %8, align 8, !dbg !632, !tbaa !498
  %13 = add i64 %12, 1, !dbg !633
  call void @llvm.dbg.value(metadata i64 %13, metadata !483, metadata !DIExpression()), !dbg !623
  store i64 %13, ptr %6, align 8, !dbg !634, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !623
  call void @llvm.dbg.value(metadata ptr %6, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !623
  %14 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5, ptr noundef nonnull %6, i64 noundef 0) #4, !dbg !635
  %15 = load i64, ptr %6, align 8, !dbg !636, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %15, metadata !483, metadata !DIExpression()), !dbg !623
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %6) #4, !dbg !629
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !629
  %16 = icmp eq i64 %15, 0, !dbg !637
  br i1 %16, label %17, label %19, !dbg !630

17:                                               ; preds = %10, %11
  %18 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @common_array_lookup_same_keys.____fmt, i32 noundef 36) #4, !dbg !638
  br label %19, !dbg !641

19:                                               ; preds = %17, %11
  %20 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !642
  call void @llvm.dbg.value(metadata i64 %20, metadata !158, metadata !DIExpression()), !dbg !621
  call void @llvm.dbg.value(metadata i32 0, metadata !159, metadata !DIExpression()), !dbg !643
  br label %30, !dbg !644

21:                                               ; preds = %37
  %22 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !645
  call void @llvm.dbg.value(metadata i64 %22, metadata !161, metadata !DIExpression()), !dbg !621
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3), !dbg !646
  call void @llvm.dbg.value(metadata i64 %20, metadata !518, metadata !DIExpression()), !dbg !646
  call void @llvm.dbg.value(metadata i64 %22, metadata !519, metadata !DIExpression()), !dbg !646
  call void @llvm.dbg.value(metadata i32 %7, metadata !520, metadata !DIExpression()), !dbg !646
  store i32 %7, ptr %3, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !646
  %23 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3) #4, !dbg !649
  call void @llvm.dbg.value(metadata ptr %23, metadata !521, metadata !DIExpression()), !dbg !646
  %24 = icmp eq ptr %23, null, !dbg !650
  br i1 %24, label %40, label %25, !dbg !651

25:                                               ; preds = %21
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #4, !dbg !652
  %26 = load i64, ptr %23, align 8, !dbg !653, !tbaa !498
  %27 = sub i64 %22, %20, !dbg !654
  %28 = add i64 %27, %26, !dbg !655
  call void @llvm.dbg.value(metadata i64 %28, metadata !522, metadata !DIExpression()), !dbg !646
  store i64 %28, ptr %4, align 8, !dbg !656, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !646
  call void @llvm.dbg.value(metadata ptr %4, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !646
  %29 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3, ptr noundef nonnull %4, i64 noundef 0) #4, !dbg !657
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #4, !dbg !658
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !658
  br label %42, !dbg !659

30:                                               ; preds = %19, %37
  %31 = phi i32 [ 0, %19 ], [ %38, %37 ]
  call void @llvm.dbg.value(metadata i32 %31, metadata !159, metadata !DIExpression()), !dbg !643
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !660
  call void @llvm.dbg.value(metadata i32 0, metadata !542, metadata !DIExpression()), !dbg !660
  store i32 0, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr @common_array, metadata !543, metadata !DIExpression()), !dbg !660
  call void @llvm.dbg.value(metadata ptr %2, metadata !542, metadata !DIExpression(DW_OP_deref)), !dbg !660
  %32 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @common_array, ptr noundef nonnull %2) #4, !dbg !663
  call void @llvm.dbg.value(metadata ptr %32, metadata !544, metadata !DIExpression()), !dbg !660
  %33 = icmp eq ptr %32, null, !dbg !664
  br i1 %33, label %37, label %34, !dbg !665

34:                                               ; preds = %30
  %35 = load i64, ptr %32, align 8, !dbg !666, !tbaa !498
  %36 = add i64 %35, 1, !dbg !666
  store i64 %36, ptr %32, align 8, !dbg !666, !tbaa !498
  br label %37, !dbg !667

37:                                               ; preds = %30, %34
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !668
  %38 = add nuw nsw i32 %31, 1, !dbg !669
  call void @llvm.dbg.value(metadata i32 %38, metadata !159, metadata !DIExpression()), !dbg !643
  %39 = icmp eq i32 %38, 100, !dbg !670
  br i1 %39, label %21, label %30, !dbg !644, !llvm.loop !671

40:                                               ; preds = %21
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !658
  %41 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @common_array_lookup_same_keys.____fmt.3, i32 noundef 34) #4, !dbg !673
  br label %42, !dbg !676

42:                                               ; preds = %25, %40
  ret i32 1, !dbg !677
}

; Function Attrs: nounwind
define dso_local i32 @simply_drop(ptr nocapture readnone %0) #0 section "xdp" !dbg !172 {
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !174, metadata !DIExpression()), !dbg !678
  %6 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !679
  call void @llvm.dbg.value(metadata i32 %6, metadata !175, metadata !DIExpression()), !dbg !678
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4), !dbg !680
  call void @llvm.dbg.value(metadata i32 %6, metadata !481, metadata !DIExpression()), !dbg !680
  store i32 %6, ptr %4, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %4, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !680
  %7 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %4) #4, !dbg !683
  call void @llvm.dbg.value(metadata ptr %7, metadata !482, metadata !DIExpression()), !dbg !680
  %8 = icmp eq ptr %7, null, !dbg !684
  br i1 %8, label %9, label %10, !dbg !685

9:                                                ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !686
  br label %16, !dbg !687

10:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %5) #4, !dbg !688
  %11 = load i64, ptr %7, align 8, !dbg !689, !tbaa !498
  %12 = add i64 %11, 1, !dbg !690
  call void @llvm.dbg.value(metadata i64 %12, metadata !483, metadata !DIExpression()), !dbg !680
  store i64 %12, ptr %5, align 8, !dbg !691, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %4, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !680
  call void @llvm.dbg.value(metadata ptr %5, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !680
  %13 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %4, ptr noundef nonnull %5, i64 noundef 0) #4, !dbg !692
  %14 = load i64, ptr %5, align 8, !dbg !693, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %14, metadata !483, metadata !DIExpression()), !dbg !680
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %5) #4, !dbg !686
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !686
  %15 = icmp eq i64 %14, 0, !dbg !694
  br i1 %15, label %16, label %18, !dbg !687

16:                                               ; preds = %9, %10
  %17 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @simply_drop.____fmt, i32 noundef 36) #4, !dbg !695
  br label %18, !dbg !698

18:                                               ; preds = %16, %10
  %19 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !699
  call void @llvm.dbg.value(metadata i64 %19, metadata !176, metadata !DIExpression()), !dbg !678
  %20 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !700
  call void @llvm.dbg.value(metadata i64 %20, metadata !177, metadata !DIExpression()), !dbg !678
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !701
  call void @llvm.dbg.value(metadata i64 %19, metadata !518, metadata !DIExpression()), !dbg !701
  call void @llvm.dbg.value(metadata i64 %20, metadata !519, metadata !DIExpression()), !dbg !701
  call void @llvm.dbg.value(metadata i32 %6, metadata !520, metadata !DIExpression()), !dbg !701
  store i32 %6, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !701
  %21 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2) #4, !dbg !704
  call void @llvm.dbg.value(metadata ptr %21, metadata !521, metadata !DIExpression()), !dbg !701
  %22 = icmp eq ptr %21, null, !dbg !705
  br i1 %22, label %28, label %23, !dbg !706

23:                                               ; preds = %18
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #4, !dbg !707
  %24 = load i64, ptr %21, align 8, !dbg !708, !tbaa !498
  %25 = sub i64 %20, %19, !dbg !709
  %26 = add i64 %25, %24, !dbg !710
  call void @llvm.dbg.value(metadata i64 %26, metadata !522, metadata !DIExpression()), !dbg !701
  store i64 %26, ptr %3, align 8, !dbg !711, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !701
  call void @llvm.dbg.value(metadata ptr %3, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !701
  %27 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2, ptr noundef nonnull %3, i64 noundef 0) #4, !dbg !712
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #4, !dbg !713
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !713
  br label %30, !dbg !714

28:                                               ; preds = %18
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !713
  %29 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @simply_drop.____fmt.4, i32 noundef 34) #4, !dbg !715
  br label %30, !dbg !718

30:                                               ; preds = %23, %28
  ret i32 1, !dbg !719
}

; Function Attrs: nounwind
define dso_local i32 @map_of_maps_queue(ptr nocapture readnone %0) #0 section "xdp" !dbg !182 {
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !184, metadata !DIExpression()), !dbg !720
  %9 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !721
  call void @llvm.dbg.value(metadata i32 %9, metadata !185, metadata !DIExpression()), !dbg !720
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %7), !dbg !722
  call void @llvm.dbg.value(metadata i32 %9, metadata !481, metadata !DIExpression()), !dbg !722
  store i32 %9, ptr %7, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %7, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !722
  %10 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %7) #4, !dbg !724
  call void @llvm.dbg.value(metadata ptr %10, metadata !482, metadata !DIExpression()), !dbg !722
  %11 = icmp eq ptr %10, null, !dbg !725
  br i1 %11, label %12, label %13, !dbg !726

12:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %7), !dbg !727
  call void @llvm.dbg.value(metadata i64 0, metadata !186, metadata !DIExpression()), !dbg !720
  br label %19, !dbg !728

13:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %8) #4, !dbg !729
  %14 = load i64, ptr %10, align 8, !dbg !730, !tbaa !498
  %15 = add i64 %14, 1, !dbg !731
  call void @llvm.dbg.value(metadata i64 %15, metadata !483, metadata !DIExpression()), !dbg !722
  store i64 %15, ptr %8, align 8, !dbg !732, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %7, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !722
  call void @llvm.dbg.value(metadata ptr %8, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !722
  %16 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %7, ptr noundef nonnull %8, i64 noundef 0) #4, !dbg !733
  %17 = load i64, ptr %8, align 8, !dbg !734, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %17, metadata !483, metadata !DIExpression()), !dbg !722
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %8) #4, !dbg !727
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %7), !dbg !727
  call void @llvm.dbg.value(metadata i64 %17, metadata !186, metadata !DIExpression()), !dbg !720
  %18 = icmp eq i64 %17, 0, !dbg !735
  br i1 %18, label %19, label %21, !dbg !728

19:                                               ; preds = %12, %13
  %20 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @map_of_maps_queue.____fmt, i32 noundef 36) #4, !dbg !737
  br label %21, !dbg !740

21:                                               ; preds = %19, %13
  %22 = phi i64 [ 0, %19 ], [ %17, %13 ]
  %23 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !741
  call void @llvm.dbg.value(metadata i64 %23, metadata !187, metadata !DIExpression()), !dbg !720
  call void @llvm.dbg.value(metadata i32 0, metadata !188, metadata !DIExpression()), !dbg !742
  br label %33, !dbg !743

24:                                               ; preds = %50
  %25 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !744
  call void @llvm.dbg.value(metadata i64 %25, metadata !190, metadata !DIExpression()), !dbg !720
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5), !dbg !745
  call void @llvm.dbg.value(metadata i64 %23, metadata !518, metadata !DIExpression()), !dbg !745
  call void @llvm.dbg.value(metadata i64 %25, metadata !519, metadata !DIExpression()), !dbg !745
  call void @llvm.dbg.value(metadata i32 %9, metadata !520, metadata !DIExpression()), !dbg !745
  store i32 %9, ptr %5, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %5, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !745
  %26 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %5) #4, !dbg !748
  call void @llvm.dbg.value(metadata ptr %26, metadata !521, metadata !DIExpression()), !dbg !745
  %27 = icmp eq ptr %26, null, !dbg !749
  br i1 %27, label %53, label %28, !dbg !750

28:                                               ; preds = %24
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %6) #4, !dbg !751
  %29 = load i64, ptr %26, align 8, !dbg !752, !tbaa !498
  %30 = sub i64 %25, %23, !dbg !753
  %31 = add i64 %30, %29, !dbg !754
  call void @llvm.dbg.value(metadata i64 %31, metadata !522, metadata !DIExpression()), !dbg !745
  store i64 %31, ptr %6, align 8, !dbg !755, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %5, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !745
  call void @llvm.dbg.value(metadata ptr %6, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !745
  %32 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %5, ptr noundef nonnull %6, i64 noundef 0) #4, !dbg !756
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %6) #4, !dbg !757
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !757
  br label %55, !dbg !758

33:                                               ; preds = %21, %50
  %34 = phi i32 [ 0, %21 ], [ %51, %50 ]
  call void @llvm.dbg.value(metadata i32 %34, metadata !188, metadata !DIExpression()), !dbg !742
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !759
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3), !dbg !759
  call void @llvm.dbg.value(metadata i32 %9, metadata !398, metadata !DIExpression()), !dbg !759
  store i32 %9, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata i64 %17, metadata !399, metadata !DIExpression()), !dbg !759
  store i64 %22, ptr %3, align 8, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %2, metadata !398, metadata !DIExpression(DW_OP_deref)), !dbg !759
  %35 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @outer_map_queue, ptr noundef nonnull %2) #4, !dbg !762
  call void @llvm.dbg.value(metadata ptr %35, metadata !400, metadata !DIExpression()), !dbg !759
  %36 = icmp eq ptr %35, null, !dbg !763
  br i1 %36, label %37, label %39, !dbg !765

37:                                               ; preds = %33
  %38 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lookup_map_of_maps_queue.____fmt, i32 noundef 35) #4, !dbg !766
  br label %50, !dbg !769

39:                                               ; preds = %33
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #4, !dbg !770
  call void @llvm.dbg.value(metadata ptr %4, metadata !401, metadata !DIExpression(DW_OP_deref)), !dbg !759
  %40 = call i64 inttoptr (i64 89 to ptr)(ptr noundef nonnull %35, ptr noundef nonnull %4) #4, !dbg !771
  %41 = icmp slt i64 %40, 0, !dbg !773
  br i1 %41, label %42, label %44, !dbg !774

42:                                               ; preds = %39
  %43 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lookup_map_of_maps_queue.____fmt.12, i32 noundef 40) #4, !dbg !775
  br label %49, !dbg !778

44:                                               ; preds = %39
  call void @llvm.dbg.value(metadata ptr %3, metadata !399, metadata !DIExpression(DW_OP_deref)), !dbg !759
  %45 = call i64 inttoptr (i64 87 to ptr)(ptr noundef nonnull %35, ptr noundef nonnull %3, i64 noundef 2) #4, !dbg !779
  %46 = icmp slt i64 %45, 0, !dbg !781
  br i1 %46, label %47, label %49, !dbg !782

47:                                               ; preds = %44
  %48 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lookup_map_of_maps_queue.____fmt.13, i32 noundef 38) #4, !dbg !783
  br label %49, !dbg !786

49:                                               ; preds = %44, %47, %42
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #4, !dbg !787
  br label %50

50:                                               ; preds = %37, %49
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !787
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3), !dbg !787
  %51 = add nuw nsw i32 %34, 1, !dbg !788
  call void @llvm.dbg.value(metadata i32 %51, metadata !188, metadata !DIExpression()), !dbg !742
  %52 = icmp eq i32 %51, 100, !dbg !789
  br i1 %52, label %24, label %33, !dbg !743, !llvm.loop !790

53:                                               ; preds = %24
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !757
  %54 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @map_of_maps_queue.____fmt.5, i32 noundef 34) #4, !dbg !792
  br label %55, !dbg !795

55:                                               ; preds = %28, %53
  ret i32 1, !dbg !796
}

; Function Attrs: nounwind
define dso_local i32 @map_of_maps_array(ptr nocapture readnone %0) #0 section "xdp" !dbg !195 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !197, metadata !DIExpression()), !dbg !797
  %8 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !798
  call void @llvm.dbg.value(metadata i32 %8, metadata !198, metadata !DIExpression()), !dbg !797
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %6), !dbg !799
  call void @llvm.dbg.value(metadata i32 %8, metadata !481, metadata !DIExpression()), !dbg !799
  store i32 %8, ptr %6, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %6, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !799
  %9 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %6) #4, !dbg !802
  call void @llvm.dbg.value(metadata ptr %9, metadata !482, metadata !DIExpression()), !dbg !799
  %10 = icmp eq ptr %9, null, !dbg !803
  br i1 %10, label %11, label %12, !dbg !804

11:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %6), !dbg !805
  br label %18, !dbg !806

12:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %7) #4, !dbg !807
  %13 = load i64, ptr %9, align 8, !dbg !808, !tbaa !498
  %14 = add i64 %13, 1, !dbg !809
  call void @llvm.dbg.value(metadata i64 %14, metadata !483, metadata !DIExpression()), !dbg !799
  store i64 %14, ptr %7, align 8, !dbg !810, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %6, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !799
  call void @llvm.dbg.value(metadata ptr %7, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !799
  %15 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %6, ptr noundef nonnull %7, i64 noundef 0) #4, !dbg !811
  %16 = load i64, ptr %7, align 8, !dbg !812, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %16, metadata !483, metadata !DIExpression()), !dbg !799
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %7) #4, !dbg !805
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %6), !dbg !805
  %17 = icmp eq i64 %16, 0, !dbg !813
  br i1 %17, label %18, label %20, !dbg !806

18:                                               ; preds = %11, %12
  %19 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @map_of_maps_array.____fmt, i32 noundef 36) #4, !dbg !814
  br label %20, !dbg !817

20:                                               ; preds = %18, %12
  %21 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !818
  call void @llvm.dbg.value(metadata i64 %21, metadata !199, metadata !DIExpression()), !dbg !797
  call void @llvm.dbg.value(metadata i32 0, metadata !200, metadata !DIExpression()), !dbg !819
  br label %31, !dbg !820

22:                                               ; preds = %44
  %23 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !821
  call void @llvm.dbg.value(metadata i64 %23, metadata !202, metadata !DIExpression()), !dbg !797
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4), !dbg !822
  call void @llvm.dbg.value(metadata i64 %21, metadata !518, metadata !DIExpression()), !dbg !822
  call void @llvm.dbg.value(metadata i64 %23, metadata !519, metadata !DIExpression()), !dbg !822
  call void @llvm.dbg.value(metadata i32 %8, metadata !520, metadata !DIExpression()), !dbg !822
  store i32 %8, ptr %4, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %4, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !822
  %24 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %4) #4, !dbg !825
  call void @llvm.dbg.value(metadata ptr %24, metadata !521, metadata !DIExpression()), !dbg !822
  %25 = icmp eq ptr %24, null, !dbg !826
  br i1 %25, label %47, label %26, !dbg !827

26:                                               ; preds = %22
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %5) #4, !dbg !828
  %27 = load i64, ptr %24, align 8, !dbg !829, !tbaa !498
  %28 = sub i64 %23, %21, !dbg !830
  %29 = add i64 %28, %27, !dbg !831
  call void @llvm.dbg.value(metadata i64 %29, metadata !522, metadata !DIExpression()), !dbg !822
  store i64 %29, ptr %5, align 8, !dbg !832, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %4, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !822
  call void @llvm.dbg.value(metadata ptr %5, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !822
  %30 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %4, ptr noundef nonnull %5, i64 noundef 0) #4, !dbg !833
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %5) #4, !dbg !834
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !834
  br label %49, !dbg !835

31:                                               ; preds = %20, %44
  %32 = phi i32 [ 0, %20 ], [ %45, %44 ]
  call void @llvm.dbg.value(metadata i32 %32, metadata !200, metadata !DIExpression()), !dbg !819
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !836
  call void @llvm.dbg.value(metadata i32 %8, metadata !428, metadata !DIExpression()), !dbg !836
  store i32 %8, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %2, metadata !428, metadata !DIExpression(DW_OP_deref)), !dbg !836
  %33 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @outer_map_array, ptr noundef nonnull %2) #4, !dbg !839
  call void @llvm.dbg.value(metadata ptr %33, metadata !429, metadata !DIExpression()), !dbg !836
  %34 = icmp eq ptr %33, null, !dbg !840
  br i1 %34, label %35, label %37, !dbg !842

35:                                               ; preds = %31
  %36 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lookup_map_of_maps_array.____fmt, i32 noundef 35) #4, !dbg !843
  br label %44, !dbg !846

37:                                               ; preds = %31
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3) #4, !dbg !847
  call void @llvm.dbg.value(metadata i32 0, metadata !430, metadata !DIExpression()), !dbg !836
  store i32 0, ptr %3, align 4, !dbg !848, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %3, metadata !430, metadata !DIExpression(DW_OP_deref)), !dbg !836
  %38 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull %33, ptr noundef nonnull %3) #4, !dbg !849
  call void @llvm.dbg.value(metadata ptr %38, metadata !431, metadata !DIExpression()), !dbg !836
  %39 = icmp eq ptr %38, null, !dbg !850
  br i1 %39, label %43, label %40, !dbg !852

40:                                               ; preds = %37
  %41 = load i64, ptr %38, align 8, !dbg !853, !tbaa !498
  %42 = add i64 %41, 1, !dbg !853
  store i64 %42, ptr %38, align 8, !dbg !853, !tbaa !498
  br label %43, !dbg !854

43:                                               ; preds = %40, %37
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3) #4, !dbg !855
  br label %44

44:                                               ; preds = %35, %43
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !855
  %45 = add nuw nsw i32 %32, 1, !dbg !856
  call void @llvm.dbg.value(metadata i32 %45, metadata !200, metadata !DIExpression()), !dbg !819
  %46 = icmp eq i32 %45, 100, !dbg !857
  br i1 %46, label %22, label %31, !dbg !820, !llvm.loop !858

47:                                               ; preds = %22
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !834
  %48 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @map_of_maps_array.____fmt.6, i32 noundef 34) #4, !dbg !860
  br label %49, !dbg !863

49:                                               ; preds = %26, %47
  ret i32 1, !dbg !864
}

; Function Attrs: nounwind
define dso_local i32 @gets_cpu_id(ptr nocapture readnone %0) #0 section "xdp" !dbg !207 {
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !209, metadata !DIExpression()), !dbg !865
  %6 = tail call i64 inttoptr (i64 5 to ptr)() #4, !dbg !866
  call void @llvm.dbg.value(metadata i64 %6, metadata !211, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 0, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 undef, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 0, metadata !212, metadata !DIExpression()), !dbg !867
  %7 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %7, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 1, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 1, metadata !212, metadata !DIExpression()), !dbg !867
  %8 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %8, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 2, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 2, metadata !212, metadata !DIExpression()), !dbg !867
  %9 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %9, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 3, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 3, metadata !212, metadata !DIExpression()), !dbg !867
  %10 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %10, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 4, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 4, metadata !212, metadata !DIExpression()), !dbg !867
  %11 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %11, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 5, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 5, metadata !212, metadata !DIExpression()), !dbg !867
  %12 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %12, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 6, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 6, metadata !212, metadata !DIExpression()), !dbg !867
  %13 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %13, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 7, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 7, metadata !212, metadata !DIExpression()), !dbg !867
  %14 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %14, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 8, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 8, metadata !212, metadata !DIExpression()), !dbg !867
  %15 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %15, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 9, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 9, metadata !212, metadata !DIExpression()), !dbg !867
  %16 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %16, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 10, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 10, metadata !212, metadata !DIExpression()), !dbg !867
  %17 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %17, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 11, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 11, metadata !212, metadata !DIExpression()), !dbg !867
  %18 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %18, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 12, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 12, metadata !212, metadata !DIExpression()), !dbg !867
  %19 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %19, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 13, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 13, metadata !212, metadata !DIExpression()), !dbg !867
  %20 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %20, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 14, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 14, metadata !212, metadata !DIExpression()), !dbg !867
  %21 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %21, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 15, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 15, metadata !212, metadata !DIExpression()), !dbg !867
  %22 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %22, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 16, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 16, metadata !212, metadata !DIExpression()), !dbg !867
  %23 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %23, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 17, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 17, metadata !212, metadata !DIExpression()), !dbg !867
  %24 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %24, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 18, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 18, metadata !212, metadata !DIExpression()), !dbg !867
  %25 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %25, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 19, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 19, metadata !212, metadata !DIExpression()), !dbg !867
  %26 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %26, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 20, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 20, metadata !212, metadata !DIExpression()), !dbg !867
  %27 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %27, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 21, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 21, metadata !212, metadata !DIExpression()), !dbg !867
  %28 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %28, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 22, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 22, metadata !212, metadata !DIExpression()), !dbg !867
  %29 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %29, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 23, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 23, metadata !212, metadata !DIExpression()), !dbg !867
  %30 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %30, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 24, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 24, metadata !212, metadata !DIExpression()), !dbg !867
  %31 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %31, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 25, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 25, metadata !212, metadata !DIExpression()), !dbg !867
  %32 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %32, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 26, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 26, metadata !212, metadata !DIExpression()), !dbg !867
  %33 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %33, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 27, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 27, metadata !212, metadata !DIExpression()), !dbg !867
  %34 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %34, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 28, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 28, metadata !212, metadata !DIExpression()), !dbg !867
  %35 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %35, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 29, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 29, metadata !212, metadata !DIExpression()), !dbg !867
  %36 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %36, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 30, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 30, metadata !212, metadata !DIExpression()), !dbg !867
  %37 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %37, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 31, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 31, metadata !212, metadata !DIExpression()), !dbg !867
  %38 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %38, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 32, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 32, metadata !212, metadata !DIExpression()), !dbg !867
  %39 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %39, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 33, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 33, metadata !212, metadata !DIExpression()), !dbg !867
  %40 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %40, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 34, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 34, metadata !212, metadata !DIExpression()), !dbg !867
  %41 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %41, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 35, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 35, metadata !212, metadata !DIExpression()), !dbg !867
  %42 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %42, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 36, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 36, metadata !212, metadata !DIExpression()), !dbg !867
  %43 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %43, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 37, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 37, metadata !212, metadata !DIExpression()), !dbg !867
  %44 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %44, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 38, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 38, metadata !212, metadata !DIExpression()), !dbg !867
  %45 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %45, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 39, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 39, metadata !212, metadata !DIExpression()), !dbg !867
  %46 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %46, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 40, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 40, metadata !212, metadata !DIExpression()), !dbg !867
  %47 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %47, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 41, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 41, metadata !212, metadata !DIExpression()), !dbg !867
  %48 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %48, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 42, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 42, metadata !212, metadata !DIExpression()), !dbg !867
  %49 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %49, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 43, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 43, metadata !212, metadata !DIExpression()), !dbg !867
  %50 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %50, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 44, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 44, metadata !212, metadata !DIExpression()), !dbg !867
  %51 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %51, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 45, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 45, metadata !212, metadata !DIExpression()), !dbg !867
  %52 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %52, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 46, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 46, metadata !212, metadata !DIExpression()), !dbg !867
  %53 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %53, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 47, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 47, metadata !212, metadata !DIExpression()), !dbg !867
  %54 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %54, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 48, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 48, metadata !212, metadata !DIExpression()), !dbg !867
  %55 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %55, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 49, metadata !212, metadata !DIExpression()), !dbg !867
  call void @llvm.dbg.value(metadata i32 49, metadata !212, metadata !DIExpression()), !dbg !867
  %56 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !868
  call void @llvm.dbg.value(metadata i32 %56, metadata !210, metadata !DIExpression()), !dbg !865
  call void @llvm.dbg.value(metadata i32 50, metadata !212, metadata !DIExpression()), !dbg !867
  %57 = tail call i64 inttoptr (i64 5 to ptr)() #4, !dbg !870
  call void @llvm.dbg.value(metadata i64 %57, metadata !214, metadata !DIExpression()), !dbg !865
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4), !dbg !871
  call void @llvm.dbg.value(metadata i32 %56, metadata !481, metadata !DIExpression()), !dbg !871
  store i32 %56, ptr %4, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %4, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !871
  %58 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %4) #4, !dbg !874
  call void @llvm.dbg.value(metadata ptr %58, metadata !482, metadata !DIExpression()), !dbg !871
  %59 = icmp eq ptr %58, null, !dbg !875
  br i1 %59, label %60, label %61, !dbg !876

60:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !877
  br label %67, !dbg !878

61:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %5) #4, !dbg !879
  %62 = load i64, ptr %58, align 8, !dbg !880, !tbaa !498
  %63 = add i64 %62, 1, !dbg !881
  call void @llvm.dbg.value(metadata i64 %63, metadata !483, metadata !DIExpression()), !dbg !871
  store i64 %63, ptr %5, align 8, !dbg !882, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %4, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !871
  call void @llvm.dbg.value(metadata ptr %5, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !871
  %64 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %4, ptr noundef nonnull %5, i64 noundef 0) #4, !dbg !883
  %65 = load i64, ptr %5, align 8, !dbg !884, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %65, metadata !483, metadata !DIExpression()), !dbg !871
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %5) #4, !dbg !877
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !877
  %66 = icmp eq i64 %65, 0, !dbg !885
  br i1 %66, label %67, label %69, !dbg !878

67:                                               ; preds = %60, %61
  %68 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @gets_cpu_id.____fmt, i32 noundef 36) #4, !dbg !886
  br label %69, !dbg !889

69:                                               ; preds = %67, %61
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !890
  call void @llvm.dbg.value(metadata i64 %6, metadata !518, metadata !DIExpression()), !dbg !890
  call void @llvm.dbg.value(metadata i64 %57, metadata !519, metadata !DIExpression()), !dbg !890
  call void @llvm.dbg.value(metadata i32 %56, metadata !520, metadata !DIExpression()), !dbg !890
  store i32 %56, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !890
  %70 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2) #4, !dbg !893
  call void @llvm.dbg.value(metadata ptr %70, metadata !521, metadata !DIExpression()), !dbg !890
  %71 = icmp eq ptr %70, null, !dbg !894
  br i1 %71, label %77, label %72, !dbg !895

72:                                               ; preds = %69
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #4, !dbg !896
  %73 = load i64, ptr %70, align 8, !dbg !897, !tbaa !498
  %74 = sub i64 %57, %6, !dbg !898
  %75 = add i64 %74, %73, !dbg !899
  call void @llvm.dbg.value(metadata i64 %75, metadata !522, metadata !DIExpression()), !dbg !890
  store i64 %75, ptr %3, align 8, !dbg !900, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !890
  call void @llvm.dbg.value(metadata ptr %3, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !890
  %76 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2, ptr noundef nonnull %3, i64 noundef 0) #4, !dbg !901
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #4, !dbg !902
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !902
  br label %79, !dbg !903

77:                                               ; preds = %69
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !902
  %78 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @gets_cpu_id.____fmt.7, i32 noundef 34) #4, !dbg !904
  br label %79, !dbg !907

79:                                               ; preds = %72, %77
  ret i32 1, !dbg !908
}

; Function Attrs: nounwind
define dso_local i32 @lock_map(ptr nocapture readnone %0) #0 section "xdp" !dbg !219 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !221, metadata !DIExpression()), !dbg !909
  %7 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !910
  call void @llvm.dbg.value(metadata i32 %7, metadata !222, metadata !DIExpression()), !dbg !909
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5), !dbg !911
  call void @llvm.dbg.value(metadata i32 %7, metadata !481, metadata !DIExpression()), !dbg !911
  store i32 %7, ptr %5, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !911
  %8 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5) #4, !dbg !914
  call void @llvm.dbg.value(metadata ptr %8, metadata !482, metadata !DIExpression()), !dbg !911
  %9 = icmp eq ptr %8, null, !dbg !915
  br i1 %9, label %10, label %11, !dbg !916

10:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !917
  br label %17, !dbg !918

11:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %6) #4, !dbg !919
  %12 = load i64, ptr %8, align 8, !dbg !920, !tbaa !498
  %13 = add i64 %12, 1, !dbg !921
  call void @llvm.dbg.value(metadata i64 %13, metadata !483, metadata !DIExpression()), !dbg !911
  store i64 %13, ptr %6, align 8, !dbg !922, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %5, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !911
  call void @llvm.dbg.value(metadata ptr %6, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !911
  %14 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %5, ptr noundef nonnull %6, i64 noundef 0) #4, !dbg !923
  %15 = load i64, ptr %6, align 8, !dbg !924, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %15, metadata !483, metadata !DIExpression()), !dbg !911
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %6) #4, !dbg !917
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5), !dbg !917
  %16 = icmp eq i64 %15, 0, !dbg !925
  br i1 %16, label %17, label %19, !dbg !918

17:                                               ; preds = %10, %11
  %18 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lock_map.____fmt, i32 noundef 36) #4, !dbg !926
  br label %19, !dbg !929

19:                                               ; preds = %17, %11
  %20 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !930
  call void @llvm.dbg.value(metadata i64 %20, metadata !223, metadata !DIExpression()), !dbg !909
  call void @llvm.dbg.value(metadata i32 0, metadata !224, metadata !DIExpression()), !dbg !931
  br label %30, !dbg !932

21:                                               ; preds = %42
  %22 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !933
  call void @llvm.dbg.value(metadata i64 %22, metadata !226, metadata !DIExpression()), !dbg !909
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3), !dbg !934
  call void @llvm.dbg.value(metadata i64 %20, metadata !518, metadata !DIExpression()), !dbg !934
  call void @llvm.dbg.value(metadata i64 %22, metadata !519, metadata !DIExpression()), !dbg !934
  call void @llvm.dbg.value(metadata i32 %7, metadata !520, metadata !DIExpression()), !dbg !934
  store i32 %7, ptr %3, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !934
  %23 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3) #4, !dbg !937
  call void @llvm.dbg.value(metadata ptr %23, metadata !521, metadata !DIExpression()), !dbg !934
  %24 = icmp eq ptr %23, null, !dbg !938
  br i1 %24, label %45, label %25, !dbg !939

25:                                               ; preds = %21
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4) #4, !dbg !940
  %26 = load i64, ptr %23, align 8, !dbg !941, !tbaa !498
  %27 = sub i64 %22, %20, !dbg !942
  %28 = add i64 %27, %26, !dbg !943
  call void @llvm.dbg.value(metadata i64 %28, metadata !522, metadata !DIExpression()), !dbg !934
  store i64 %28, ptr %4, align 8, !dbg !944, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %3, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !934
  call void @llvm.dbg.value(metadata ptr %4, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !934
  %29 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %3, ptr noundef nonnull %4, i64 noundef 0) #4, !dbg !945
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4) #4, !dbg !946
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !946
  br label %47, !dbg !947

30:                                               ; preds = %19, %42
  %31 = phi i32 [ 0, %19 ], [ %43, %42 ]
  call void @llvm.dbg.value(metadata i32 %31, metadata !224, metadata !DIExpression()), !dbg !931
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !948
  call void @llvm.dbg.value(metadata i32 0, metadata !436, metadata !DIExpression()), !dbg !948
  store i32 0, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %2, metadata !436, metadata !DIExpression(DW_OP_deref)), !dbg !948
  %32 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @lock_array, ptr noundef nonnull %2) #4, !dbg !951
  call void @llvm.dbg.value(metadata ptr %32, metadata !437, metadata !DIExpression()), !dbg !948
  %33 = icmp eq ptr %32, null, !dbg !952
  br i1 %33, label %34, label %36, !dbg !954

34:                                               ; preds = %30
  %35 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lookup_lock_map.____fmt, i32 noundef 36) #4, !dbg !955
  br label %42, !dbg !958

36:                                               ; preds = %30
  %37 = getelementptr inbounds %struct.map_locked_value, ptr %32, i64 0, i32 1, !dbg !959
  %38 = call i64 inttoptr (i64 93 to ptr)(ptr noundef nonnull %37) #4, !dbg !960
  %39 = load i64, ptr %32, align 8, !dbg !961, !tbaa !962
  %40 = add i64 %39, 1, !dbg !961
  store i64 %40, ptr %32, align 8, !dbg !961, !tbaa !962
  %41 = call i64 inttoptr (i64 94 to ptr)(ptr noundef nonnull %37) #4, !dbg !965
  br label %42, !dbg !966

42:                                               ; preds = %34, %36
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !967
  %43 = add nuw nsw i32 %31, 1, !dbg !968
  call void @llvm.dbg.value(metadata i32 %43, metadata !224, metadata !DIExpression()), !dbg !931
  %44 = icmp eq i32 %43, 100, !dbg !969
  br i1 %44, label %21, label %30, !dbg !932, !llvm.loop !970

45:                                               ; preds = %21
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3), !dbg !946
  %46 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lock_map.____fmt.8, i32 noundef 34) #4, !dbg !972
  br label %47, !dbg !975

47:                                               ; preds = %25, %45
  ret i32 1, !dbg !976
}

; Function Attrs: nounwind
define dso_local i32 @map_of_maps_hash(ptr nocapture readnone %0) #0 section "xdp" !dbg !231 {
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.hash_key, align 4
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !233, metadata !DIExpression()), !dbg !977
  %8 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !978
  %9 = zext i32 %8 to i64, !dbg !978
  call void @llvm.dbg.value(metadata i64 %9, metadata !234, metadata !DIExpression()), !dbg !977
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %6), !dbg !979
  call void @llvm.dbg.value(metadata i32 %8, metadata !481, metadata !DIExpression()), !dbg !979
  store i32 %8, ptr %6, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %6, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !979
  %10 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %6) #4, !dbg !982
  call void @llvm.dbg.value(metadata ptr %10, metadata !482, metadata !DIExpression()), !dbg !979
  %11 = icmp eq ptr %10, null, !dbg !983
  br i1 %11, label %12, label %13, !dbg !984

12:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %6), !dbg !985
  br label %19, !dbg !986

13:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %7) #4, !dbg !987
  %14 = load i64, ptr %10, align 8, !dbg !988, !tbaa !498
  %15 = add i64 %14, 1, !dbg !989
  call void @llvm.dbg.value(metadata i64 %15, metadata !483, metadata !DIExpression()), !dbg !979
  store i64 %15, ptr %7, align 8, !dbg !990, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %6, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !979
  call void @llvm.dbg.value(metadata ptr %7, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !979
  %16 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %6, ptr noundef nonnull %7, i64 noundef 0) #4, !dbg !991
  %17 = load i64, ptr %7, align 8, !dbg !992, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %17, metadata !483, metadata !DIExpression()), !dbg !979
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %7) #4, !dbg !985
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %6), !dbg !985
  %18 = icmp eq i64 %17, 0, !dbg !993
  br i1 %18, label %19, label %21, !dbg !986

19:                                               ; preds = %12, %13
  %20 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @map_of_maps_hash.____fmt, i32 noundef 36) #4, !dbg !994
  br label %21, !dbg !997

21:                                               ; preds = %19, %13
  %22 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !998
  call void @llvm.dbg.value(metadata i64 %22, metadata !235, metadata !DIExpression()), !dbg !977
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %4), !dbg !999
  call void @llvm.dbg.value(metadata i64 %9, metadata !452, metadata !DIExpression()), !dbg !999
  store i64 %9, ptr %4, align 8, !tbaa !498
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %5) #4, !dbg !1001
  call void @llvm.dbg.declare(metadata ptr %5, metadata !453, metadata !DIExpression()), !dbg !1002
  store i32 %8, ptr %5, align 4, !dbg !1003, !tbaa !1004
  %23 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @outer_map_hash, ptr noundef nonnull %5) #4, !dbg !1006
  call void @llvm.dbg.value(metadata ptr %23, metadata !454, metadata !DIExpression()), !dbg !999
  %24 = icmp eq ptr %23, null, !dbg !1007
  br i1 %24, label %25, label %27, !dbg !1009

25:                                               ; preds = %21
  %26 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lookup_map_of_maps_hash.____fmt, i32 noundef 35) #4, !dbg !1010
  br label %35, !dbg !1013

27:                                               ; preds = %21
  call void @llvm.dbg.value(metadata ptr %4, metadata !452, metadata !DIExpression(DW_OP_deref)), !dbg !999
  %28 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull %23, ptr noundef nonnull %4) #4, !dbg !1014
  call void @llvm.dbg.value(metadata ptr %28, metadata !455, metadata !DIExpression()), !dbg !999
  %29 = icmp eq ptr %28, null, !dbg !1015
  br i1 %29, label %30, label %32, !dbg !1017

30:                                               ; preds = %27
  %31 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @lookup_map_of_maps_hash.____fmt.14, i32 noundef 32) #4, !dbg !1018
  br label %35, !dbg !1021

32:                                               ; preds = %27
  %33 = load i64, ptr %28, align 8, !dbg !1022, !tbaa !1023
  %34 = add i64 %33, 1, !dbg !1022
  store i64 %34, ptr %28, align 8, !dbg !1022, !tbaa !1023
  br label %35, !dbg !1025

35:                                               ; preds = %25, %30, %32
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %5) #4, !dbg !1026
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %4), !dbg !1026
  %36 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !1027
  call void @llvm.dbg.value(metadata i64 %36, metadata !236, metadata !DIExpression()), !dbg !977
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !1028
  call void @llvm.dbg.value(metadata i64 %22, metadata !518, metadata !DIExpression()), !dbg !1028
  call void @llvm.dbg.value(metadata i64 %36, metadata !519, metadata !DIExpression()), !dbg !1028
  call void @llvm.dbg.value(metadata i32 %8, metadata !520, metadata !DIExpression()), !dbg !1028
  store i32 %8, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !1028
  %37 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2) #4, !dbg !1031
  call void @llvm.dbg.value(metadata ptr %37, metadata !521, metadata !DIExpression()), !dbg !1028
  %38 = icmp eq ptr %37, null, !dbg !1032
  br i1 %38, label %44, label %39, !dbg !1033

39:                                               ; preds = %35
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #4, !dbg !1034
  %40 = load i64, ptr %37, align 8, !dbg !1035, !tbaa !498
  %41 = sub i64 %36, %22, !dbg !1036
  %42 = add i64 %41, %40, !dbg !1037
  call void @llvm.dbg.value(metadata i64 %42, metadata !522, metadata !DIExpression()), !dbg !1028
  store i64 %42, ptr %3, align 8, !dbg !1038, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !1028
  call void @llvm.dbg.value(metadata ptr %3, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !1028
  %43 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2, ptr noundef nonnull %3, i64 noundef 0) #4, !dbg !1039
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #4, !dbg !1040
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !1040
  br label %46, !dbg !1041

44:                                               ; preds = %35
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !1040
  %45 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @map_of_maps_hash.____fmt.9, i32 noundef 34) #4, !dbg !1042
  br label %46, !dbg !1045

46:                                               ; preds = %39, %44
  ret i32 1, !dbg !1046
}

; Function Attrs: nounwind
define dso_local i32 @common_hash_map(ptr nocapture readnone %0) #0 section "xdp" !dbg !241 {
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca %struct.hash_key, align 4
  %7 = alloca i64, align 8
  call void @llvm.dbg.value(metadata ptr poison, metadata !243, metadata !DIExpression()), !dbg !1047
  %8 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !1048
  call void @llvm.dbg.value(metadata i32 %8, metadata !244, metadata !DIExpression()), !dbg !1047
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4), !dbg !1049
  call void @llvm.dbg.value(metadata i32 %8, metadata !481, metadata !DIExpression()), !dbg !1049
  store i32 %8, ptr %4, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %4, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !1049
  %9 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %4) #4, !dbg !1052
  call void @llvm.dbg.value(metadata ptr %9, metadata !482, metadata !DIExpression()), !dbg !1049
  %10 = icmp eq ptr %9, null, !dbg !1053
  br i1 %10, label %11, label %12, !dbg !1054

11:                                               ; preds = %1
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !1055
  br label %18, !dbg !1056

12:                                               ; preds = %1
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %5) #4, !dbg !1057
  %13 = load i64, ptr %9, align 8, !dbg !1058, !tbaa !498
  %14 = add i64 %13, 1, !dbg !1059
  call void @llvm.dbg.value(metadata i64 %14, metadata !483, metadata !DIExpression()), !dbg !1049
  store i64 %14, ptr %5, align 8, !dbg !1060, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %4, metadata !481, metadata !DIExpression(DW_OP_deref)), !dbg !1049
  call void @llvm.dbg.value(metadata ptr %5, metadata !483, metadata !DIExpression(DW_OP_deref)), !dbg !1049
  %15 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @counter_array, ptr noundef nonnull %4, ptr noundef nonnull %5, i64 noundef 0) #4, !dbg !1061
  %16 = load i64, ptr %5, align 8, !dbg !1062, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %16, metadata !483, metadata !DIExpression()), !dbg !1049
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %5) #4, !dbg !1055
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4), !dbg !1055
  %17 = icmp eq i64 %16, 0, !dbg !1063
  br i1 %17, label %18, label %20, !dbg !1056

18:                                               ; preds = %11, %12
  %19 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @common_hash_map.____fmt, i32 noundef 35) #4, !dbg !1064
  br label %20, !dbg !1067

20:                                               ; preds = %18, %12
  %21 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !1068
  call void @llvm.dbg.value(metadata i64 %21, metadata !245, metadata !DIExpression()), !dbg !1047
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %6) #4, !dbg !1069
  call void @llvm.dbg.declare(metadata ptr %6, metadata !246, metadata !DIExpression()), !dbg !1070
  store i32 %8, ptr %6, align 4, !dbg !1071, !tbaa !1004
  %22 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @common_hash, ptr noundef nonnull %6) #4, !dbg !1072
  call void @llvm.dbg.value(metadata ptr %22, metadata !247, metadata !DIExpression()), !dbg !1047
  %23 = icmp eq ptr %22, null, !dbg !1073
  br i1 %23, label %24, label %31, !dbg !1074

24:                                               ; preds = %20
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %7) #4, !dbg !1075
  call void @llvm.dbg.value(metadata i64 0, metadata !248, metadata !DIExpression()), !dbg !1076
  store i64 0, ptr %7, align 8, !dbg !1077, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %7, metadata !248, metadata !DIExpression(DW_OP_deref)), !dbg !1076
  %25 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @common_hash, ptr noundef nonnull %6, ptr noundef nonnull %7, i64 noundef 1) #4, !dbg !1078
  %26 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @common_hash, ptr noundef nonnull %6) #4, !dbg !1079
  call void @llvm.dbg.value(metadata ptr %26, metadata !247, metadata !DIExpression()), !dbg !1047
  %27 = icmp eq ptr %26, null, !dbg !1080
  br i1 %27, label %28, label %30, !dbg !1082

28:                                               ; preds = %24
  %29 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @common_hash_map.____fmt.10, i32 noundef 40) #4, !dbg !1083
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %7) #4, !dbg !1086
  br label %45

30:                                               ; preds = %24
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %7) #4, !dbg !1086
  br label %31

31:                                               ; preds = %30, %20
  %32 = phi ptr [ %22, %20 ], [ %26, %30 ], !dbg !1047
  call void @llvm.dbg.value(metadata ptr %32, metadata !247, metadata !DIExpression()), !dbg !1047
  %33 = load i64, ptr %32, align 8, !dbg !1087, !tbaa !1023
  %34 = add i64 %33, 1, !dbg !1087
  store i64 %34, ptr %32, align 8, !dbg !1087, !tbaa !1023
  %35 = call i64 inttoptr (i64 5 to ptr)() #4, !dbg !1088
  call void @llvm.dbg.value(metadata i64 %35, metadata !251, metadata !DIExpression()), !dbg !1047
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2), !dbg !1089
  call void @llvm.dbg.value(metadata i64 %21, metadata !518, metadata !DIExpression()), !dbg !1089
  call void @llvm.dbg.value(metadata i64 %35, metadata !519, metadata !DIExpression()), !dbg !1089
  call void @llvm.dbg.value(metadata i32 %8, metadata !520, metadata !DIExpression()), !dbg !1089
  store i32 %8, ptr %2, align 4, !tbaa !486
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !1089
  %36 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2) #4, !dbg !1092
  call void @llvm.dbg.value(metadata ptr %36, metadata !521, metadata !DIExpression()), !dbg !1089
  %37 = icmp eq ptr %36, null, !dbg !1093
  br i1 %37, label %43, label %38, !dbg !1094

38:                                               ; preds = %31
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #4, !dbg !1095
  %39 = load i64, ptr %36, align 8, !dbg !1096, !tbaa !498
  %40 = sub i64 %35, %21, !dbg !1097
  %41 = add i64 %40, %39, !dbg !1098
  call void @llvm.dbg.value(metadata i64 %41, metadata !522, metadata !DIExpression()), !dbg !1089
  store i64 %41, ptr %3, align 8, !dbg !1099, !tbaa !498
  call void @llvm.dbg.value(metadata ptr %2, metadata !520, metadata !DIExpression(DW_OP_deref)), !dbg !1089
  call void @llvm.dbg.value(metadata ptr %3, metadata !522, metadata !DIExpression(DW_OP_deref)), !dbg !1089
  %42 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @time_array, ptr noundef nonnull %2, ptr noundef nonnull %3, i64 noundef 0) #4, !dbg !1100
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #4, !dbg !1101
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !1101
  br label %45, !dbg !1102

43:                                               ; preds = %31
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !1101
  %44 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @common_hash_map.____fmt.11, i32 noundef 33) #4, !dbg !1103
  br label %45, !dbg !1106

45:                                               ; preds = %38, %28, %43
  %46 = phi i32 [ 0, %28 ], [ 1, %43 ], [ 1, %38 ]
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %6) #4, !dbg !1107
  ret i32 %46, !dbg !1107
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!469, !470, !471, !472}
!llvm.ident = !{!473}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "inner_map_array0", scope: !2, file: !3, line: 32, type: !43, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/benchmark", checksumkind: CSK_MD5, checksum: "8ce7c758e50711d50a93a73228a265f3")
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
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 1168, baseType: !7, size: 32, elements: !15)
!15 = !{!16, !17, !18, !19}
!16 = !DIEnumerator(name: "BPF_ANY", value: 0)
!17 = !DIEnumerator(name: "BPF_NOEXIST", value: 1)
!18 = !DIEnumerator(name: "BPF_EXIST", value: 2)
!19 = !DIEnumerator(name: "BPF_F_LOCK", value: 4)
!20 = !{!21, !58, !81, !109, !135, !140, !150, !152, !165, !170, !178, !180, !191, !193, !203, !205, !215, !217, !227, !229, !237, !239, !252, !257, !259, !264, !0, !280, !282, !284, !286, !288, !290, !292, !294, !296, !298, !300, !302, !304, !306, !308, !310, !318, !330, !338, !346, !358, !360, !362, !364, !366, !368, !370, !372, !374, !380, !387, !392, !402, !404, !409, !415, !422, !432, !438, !444, !446, !456, !459, !464}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "outer_map_array", scope: !2, file: !3, line: 40, type: !23, isLocal: false, isDefinition: true)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 35, size: 192, elements: !24)
!24 = !{!25, !31, !36, !40}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !23, file: !3, line: 36, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 384, elements: !29)
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !{!30}
!30 = !DISubrange(count: 12)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !23, file: !3, line: 37, baseType: !32, size: 64, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 256, elements: !34)
!34 = !{!35}
!35 = !DISubrange(count: 8)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !23, file: !3, line: 38, baseType: !37, size: 64, offset: 128)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !39, line: 27, baseType: !7)
!39 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!40 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !23, file: !3, line: 39, baseType: !41, offset: 192)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, elements: !56)
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_map_array", file: !3, line: 27, size: 256, elements: !44)
!44 = !{!45, !50, !51, !55}
!45 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !43, file: !3, line: 28, baseType: !46, size: 64)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 64, elements: !48)
!48 = !{!49}
!49 = !DISubrange(count: 2)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !43, file: !3, line: 29, baseType: !37, size: 64, offset: 64)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !43, file: !3, line: 30, baseType: !52, size: 64, offset: 128)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !39, line: 31, baseType: !54)
!54 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !43, file: !3, line: 31, baseType: !32, size: 64, offset: 192)
!56 = !{!57}
!57 = !DISubrange(count: -1)
!58 = !DIGlobalVariableExpression(var: !59, expr: !DIExpression())
!59 = distinct !DIGlobalVariable(name: "outer_map_queue", scope: !2, file: !3, line: 58, type: !60, isLocal: false, isDefinition: true)
!60 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 53, size: 192, elements: !61)
!61 = !{!62, !63, !64, !65}
!62 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !60, file: !3, line: 54, baseType: !26, size: 64)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !60, file: !3, line: 55, baseType: !32, size: 64, offset: 64)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !60, file: !3, line: 56, baseType: !37, size: 64, offset: 128)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !60, file: !3, line: 57, baseType: !66, offset: 192)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !67, elements: !56)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_map_queue", file: !3, line: 45, size: 192, elements: !69)
!69 = !{!70, !75, !76}
!70 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !68, file: !3, line: 46, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 704, elements: !73)
!73 = !{!74}
!74 = !DISubrange(count: 22)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !68, file: !3, line: 47, baseType: !52, size: 64, offset: 64)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !68, file: !3, line: 48, baseType: !77, size: 64, offset: 128)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 1024, elements: !79)
!79 = !{!80}
!80 = !DISubrange(count: 32)
!81 = !DIGlobalVariableExpression(var: !82, expr: !DIExpression())
!82 = distinct !DIGlobalVariable(name: "outer_map_hash", scope: !2, file: !3, line: 125, type: !83, isLocal: false, isDefinition: true)
!83 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_map_hash", file: !3, line: 120, size: 192, elements: !84)
!84 = !{!85, !90, !95, !96}
!85 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !83, file: !3, line: 121, baseType: !86, size: 64)
!86 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !87, size: 64)
!87 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 416, elements: !88)
!88 = !{!89}
!89 = !DISubrange(count: 13)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !83, file: !3, line: 122, baseType: !91, size: 64, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash_key", file: !3, line: 95, size: 32, elements: !93)
!93 = !{!94}
!94 = !DIDerivedType(tag: DW_TAG_member, name: "cpu", scope: !92, file: !3, line: 96, baseType: !28, size: 32)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !83, file: !3, line: 123, baseType: !32, size: 64, offset: 128)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !83, file: !3, line: 124, baseType: !97, offset: 192)
!97 = !DICompositeType(tag: DW_TAG_array_type, baseType: !98, elements: !56)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_array_hash", file: !3, line: 106, size: 256, elements: !100)
!100 = !{!101, !102, !103, !108}
!101 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !99, file: !3, line: 107, baseType: !46, size: 64)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !99, file: !3, line: 108, baseType: !37, size: 64, offset: 64)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !99, file: !3, line: 109, baseType: !104, size: 64, offset: 128)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "map_elem", file: !3, line: 91, size: 64, elements: !106)
!106 = !{!107}
!107 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !105, file: !3, line: 92, baseType: !53, size: 64)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !99, file: !3, line: 110, baseType: !77, size: 64, offset: 192)
!109 = !DIGlobalVariableExpression(var: !110, expr: !DIExpression())
!110 = distinct !DIGlobalVariable(name: "____fmt", scope: !111, file: !3, line: 259, type: !130, isLocal: true, isDefinition: true)
!111 = distinct !DISubprogram(name: "common_array_lookup_diff_keys", scope: !3, file: !3, line: 253, type: !112, scopeLine: 254, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !123)
!112 = !DISubroutineType(types: !113)
!113 = !{!28, !114}
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!115 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5447, size: 192, elements: !116)
!116 = !{!117, !118, !119, !120, !121, !122}
!117 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !115, file: !6, line: 5448, baseType: !38, size: 32)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !115, file: !6, line: 5449, baseType: !38, size: 32, offset: 32)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !115, file: !6, line: 5450, baseType: !38, size: 32, offset: 64)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !115, file: !6, line: 5452, baseType: !38, size: 32, offset: 96)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !115, file: !6, line: 5453, baseType: !38, size: 32, offset: 128)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !115, file: !6, line: 5455, baseType: !38, size: 32, offset: 160)
!123 = !{!124, !125, !126, !127, !129}
!124 = !DILocalVariable(name: "ctx", arg: 1, scope: !111, file: !3, line: 253, type: !114)
!125 = !DILocalVariable(name: "cpu", scope: !111, file: !3, line: 255, type: !28)
!126 = !DILocalVariable(name: "arrival_time", scope: !111, file: !3, line: 262, type: !53)
!127 = !DILocalVariable(name: "i", scope: !128, file: !3, line: 265, type: !28)
!128 = distinct !DILexicalBlock(scope: !111, file: !3, line: 265, column: 5)
!129 = !DILocalVariable(name: "finish_time", scope: !111, file: !3, line: 268, type: !53)
!130 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 280, elements: !133)
!131 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !132)
!132 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!133 = !{!134}
!134 = !DISubrange(count: 35)
!135 = !DIGlobalVariableExpression(var: !136, expr: !DIExpression())
!136 = distinct !DIGlobalVariable(name: "____fmt", scope: !111, file: !3, line: 270, type: !137, isLocal: true, isDefinition: true)
!137 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 264, elements: !138)
!138 = !{!139}
!139 = !DISubrange(count: 33)
!140 = !DIGlobalVariableExpression(var: !141, expr: !DIExpression())
!141 = distinct !DIGlobalVariable(name: "____fmt", scope: !142, file: !3, line: 286, type: !130, isLocal: true, isDefinition: true)
!142 = distinct !DISubprogram(name: "percpu_array_lookup", scope: !3, file: !3, line: 280, type: !112, scopeLine: 281, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !143)
!143 = !{!144, !145, !146, !147, !149}
!144 = !DILocalVariable(name: "ctx", arg: 1, scope: !142, file: !3, line: 280, type: !114)
!145 = !DILocalVariable(name: "cpu", scope: !142, file: !3, line: 282, type: !28)
!146 = !DILocalVariable(name: "arrival_time", scope: !142, file: !3, line: 289, type: !53)
!147 = !DILocalVariable(name: "i", scope: !148, file: !3, line: 292, type: !28)
!148 = distinct !DILexicalBlock(scope: !142, file: !3, line: 292, column: 5)
!149 = !DILocalVariable(name: "finish_time", scope: !142, file: !3, line: 295, type: !53)
!150 = !DIGlobalVariableExpression(var: !151, expr: !DIExpression())
!151 = distinct !DIGlobalVariable(name: "____fmt", scope: !142, file: !3, line: 297, type: !137, isLocal: true, isDefinition: true)
!152 = !DIGlobalVariableExpression(var: !153, expr: !DIExpression())
!153 = distinct !DIGlobalVariable(name: "____fmt", scope: !154, file: !3, line: 310, type: !162, isLocal: true, isDefinition: true)
!154 = distinct !DISubprogram(name: "common_array_lookup_same_keys", scope: !3, file: !3, line: 304, type: !112, scopeLine: 305, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !155)
!155 = !{!156, !157, !158, !159, !161}
!156 = !DILocalVariable(name: "ctx", arg: 1, scope: !154, file: !3, line: 304, type: !114)
!157 = !DILocalVariable(name: "cpu", scope: !154, file: !3, line: 306, type: !28)
!158 = !DILocalVariable(name: "arrival_time", scope: !154, file: !3, line: 313, type: !53)
!159 = !DILocalVariable(name: "i", scope: !160, file: !3, line: 316, type: !28)
!160 = distinct !DILexicalBlock(scope: !154, file: !3, line: 316, column: 5)
!161 = !DILocalVariable(name: "finish_time", scope: !154, file: !3, line: 319, type: !53)
!162 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 288, elements: !163)
!163 = !{!164}
!164 = !DISubrange(count: 36)
!165 = !DIGlobalVariableExpression(var: !166, expr: !DIExpression())
!166 = distinct !DIGlobalVariable(name: "____fmt", scope: !154, file: !3, line: 321, type: !167, isLocal: true, isDefinition: true)
!167 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 272, elements: !168)
!168 = !{!169}
!169 = !DISubrange(count: 34)
!170 = !DIGlobalVariableExpression(var: !171, expr: !DIExpression())
!171 = distinct !DIGlobalVariable(name: "____fmt", scope: !172, file: !3, line: 340, type: !162, isLocal: true, isDefinition: true)
!172 = distinct !DISubprogram(name: "simply_drop", scope: !3, file: !3, line: 329, type: !112, scopeLine: 330, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !173)
!173 = !{!174, !175, !176, !177}
!174 = !DILocalVariable(name: "ctx", arg: 1, scope: !172, file: !3, line: 329, type: !114)
!175 = !DILocalVariable(name: "cpu", scope: !172, file: !3, line: 332, type: !28)
!176 = !DILocalVariable(name: "arrival_time", scope: !172, file: !3, line: 345, type: !53)
!177 = !DILocalVariable(name: "finish_time", scope: !172, file: !3, line: 371, type: !53)
!178 = !DIGlobalVariableExpression(var: !179, expr: !DIExpression())
!179 = distinct !DIGlobalVariable(name: "____fmt", scope: !172, file: !3, line: 373, type: !167, isLocal: true, isDefinition: true)
!180 = !DIGlobalVariableExpression(var: !181, expr: !DIExpression())
!181 = distinct !DIGlobalVariable(name: "____fmt", scope: !182, file: !3, line: 441, type: !162, isLocal: true, isDefinition: true)
!182 = distinct !DISubprogram(name: "map_of_maps_queue", scope: !3, file: !3, line: 434, type: !112, scopeLine: 435, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !183)
!183 = !{!184, !185, !186, !187, !188, !190}
!184 = !DILocalVariable(name: "ctx", arg: 1, scope: !182, file: !3, line: 434, type: !114)
!185 = !DILocalVariable(name: "cpu", scope: !182, file: !3, line: 436, type: !28)
!186 = !DILocalVariable(name: "counter", scope: !182, file: !3, line: 439, type: !53)
!187 = !DILocalVariable(name: "arrival_time", scope: !182, file: !3, line: 444, type: !53)
!188 = !DILocalVariable(name: "i", scope: !189, file: !3, line: 446, type: !28)
!189 = distinct !DILexicalBlock(scope: !182, file: !3, line: 446, column: 5)
!190 = !DILocalVariable(name: "finish_time", scope: !182, file: !3, line: 449, type: !53)
!191 = !DIGlobalVariableExpression(var: !192, expr: !DIExpression())
!192 = distinct !DIGlobalVariable(name: "____fmt", scope: !182, file: !3, line: 451, type: !167, isLocal: true, isDefinition: true)
!193 = !DIGlobalVariableExpression(var: !194, expr: !DIExpression())
!194 = distinct !DIGlobalVariable(name: "____fmt", scope: !195, file: !3, line: 485, type: !162, isLocal: true, isDefinition: true)
!195 = distinct !DISubprogram(name: "map_of_maps_array", scope: !3, file: !3, line: 480, type: !112, scopeLine: 481, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !196)
!196 = !{!197, !198, !199, !200, !202}
!197 = !DILocalVariable(name: "ctx", arg: 1, scope: !195, file: !3, line: 480, type: !114)
!198 = !DILocalVariable(name: "cpu", scope: !195, file: !3, line: 482, type: !28)
!199 = !DILocalVariable(name: "arrival_time", scope: !195, file: !3, line: 488, type: !53)
!200 = !DILocalVariable(name: "i", scope: !201, file: !3, line: 490, type: !28)
!201 = distinct !DILexicalBlock(scope: !195, file: !3, line: 490, column: 5)
!202 = !DILocalVariable(name: "finish_time", scope: !195, file: !3, line: 493, type: !53)
!203 = !DIGlobalVariableExpression(var: !204, expr: !DIExpression())
!204 = distinct !DIGlobalVariable(name: "____fmt", scope: !195, file: !3, line: 495, type: !167, isLocal: true, isDefinition: true)
!205 = !DIGlobalVariableExpression(var: !206, expr: !DIExpression())
!206 = distinct !DIGlobalVariable(name: "____fmt", scope: !207, file: !3, line: 514, type: !162, isLocal: true, isDefinition: true)
!207 = distinct !DISubprogram(name: "gets_cpu_id", scope: !3, file: !3, line: 502, type: !112, scopeLine: 503, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !208)
!208 = !{!209, !210, !211, !212, !214}
!209 = !DILocalVariable(name: "ctx", arg: 1, scope: !207, file: !3, line: 502, type: !114)
!210 = !DILocalVariable(name: "cpu", scope: !207, file: !3, line: 504, type: !28)
!211 = !DILocalVariable(name: "arrival_time", scope: !207, file: !3, line: 506, type: !53)
!212 = !DILocalVariable(name: "i", scope: !213, file: !3, line: 508, type: !28)
!213 = distinct !DILexicalBlock(scope: !207, file: !3, line: 508, column: 5)
!214 = !DILocalVariable(name: "finish_time", scope: !207, file: !3, line: 511, type: !53)
!215 = !DIGlobalVariableExpression(var: !216, expr: !DIExpression())
!216 = distinct !DIGlobalVariable(name: "____fmt", scope: !207, file: !3, line: 518, type: !167, isLocal: true, isDefinition: true)
!217 = !DIGlobalVariableExpression(var: !218, expr: !DIExpression())
!218 = distinct !DIGlobalVariable(name: "____fmt", scope: !219, file: !3, line: 553, type: !162, isLocal: true, isDefinition: true)
!219 = distinct !DISubprogram(name: "lock_map", scope: !3, file: !3, line: 547, type: !112, scopeLine: 548, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !220)
!220 = !{!221, !222, !223, !224, !226}
!221 = !DILocalVariable(name: "ctx", arg: 1, scope: !219, file: !3, line: 547, type: !114)
!222 = !DILocalVariable(name: "cpu", scope: !219, file: !3, line: 549, type: !28)
!223 = !DILocalVariable(name: "arrival_time", scope: !219, file: !3, line: 556, type: !53)
!224 = !DILocalVariable(name: "i", scope: !225, file: !3, line: 559, type: !28)
!225 = distinct !DILexicalBlock(scope: !219, file: !3, line: 559, column: 5)
!226 = !DILocalVariable(name: "finish_time", scope: !219, file: !3, line: 562, type: !53)
!227 = !DIGlobalVariableExpression(var: !228, expr: !DIExpression())
!228 = distinct !DIGlobalVariable(name: "____fmt", scope: !219, file: !3, line: 564, type: !167, isLocal: true, isDefinition: true)
!229 = !DIGlobalVariableExpression(var: !230, expr: !DIExpression())
!230 = distinct !DIGlobalVariable(name: "____fmt", scope: !231, file: !3, line: 613, type: !162, isLocal: true, isDefinition: true)
!231 = distinct !DISubprogram(name: "map_of_maps_hash", scope: !3, file: !3, line: 608, type: !112, scopeLine: 609, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !232)
!232 = !{!233, !234, !235, !236}
!233 = !DILocalVariable(name: "ctx", arg: 1, scope: !231, file: !3, line: 608, type: !114)
!234 = !DILocalVariable(name: "cpu", scope: !231, file: !3, line: 610, type: !53)
!235 = !DILocalVariable(name: "arrival_time", scope: !231, file: !3, line: 616, type: !53)
!236 = !DILocalVariable(name: "finish_time", scope: !231, file: !3, line: 621, type: !53)
!237 = !DIGlobalVariableExpression(var: !238, expr: !DIExpression())
!238 = distinct !DIGlobalVariable(name: "____fmt", scope: !231, file: !3, line: 623, type: !167, isLocal: true, isDefinition: true)
!239 = !DIGlobalVariableExpression(var: !240, expr: !DIExpression())
!240 = distinct !DIGlobalVariable(name: "____fmt", scope: !241, file: !3, line: 636, type: !130, isLocal: true, isDefinition: true)
!241 = distinct !DISubprogram(name: "common_hash_map", scope: !3, file: !3, line: 630, type: !112, scopeLine: 631, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !242)
!242 = !{!243, !244, !245, !246, !247, !248, !251}
!243 = !DILocalVariable(name: "ctx", arg: 1, scope: !241, file: !3, line: 630, type: !114)
!244 = !DILocalVariable(name: "cpu", scope: !241, file: !3, line: 632, type: !28)
!245 = !DILocalVariable(name: "arrival_time", scope: !241, file: !3, line: 639, type: !53)
!246 = !DILocalVariable(name: "hash_map_key", scope: !241, file: !3, line: 643, type: !92)
!247 = !DILocalVariable(name: "elem", scope: !241, file: !3, line: 644, type: !104)
!248 = !DILocalVariable(name: "new_value", scope: !249, file: !3, line: 646, type: !53)
!249 = distinct !DILexicalBlock(scope: !250, file: !3, line: 645, column: 19)
!250 = distinct !DILexicalBlock(scope: !241, file: !3, line: 645, column: 12)
!251 = !DILocalVariable(name: "finish_time", scope: !241, file: !3, line: 658, type: !53)
!252 = !DIGlobalVariableExpression(var: !253, expr: !DIExpression())
!253 = distinct !DIGlobalVariable(name: "____fmt", scope: !241, file: !3, line: 651, type: !254, isLocal: true, isDefinition: true)
!254 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 320, elements: !255)
!255 = !{!256}
!256 = !DISubrange(count: 40)
!257 = !DIGlobalVariableExpression(var: !258, expr: !DIExpression())
!258 = distinct !DIGlobalVariable(name: "____fmt", scope: !241, file: !3, line: 660, type: !137, isLocal: true, isDefinition: true)
!259 = !DIGlobalVariableExpression(var: !260, expr: !DIExpression())
!260 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 668, type: !261, isLocal: false, isDefinition: true)
!261 = !DICompositeType(tag: DW_TAG_array_type, baseType: !132, size: 32, elements: !262)
!262 = !{!263}
!263 = !DISubrange(count: 4)
!264 = !DIGlobalVariableExpression(var: !265, expr: !DIExpression())
!265 = distinct !DIGlobalVariable(name: "lock_array", scope: !2, file: !3, line: 25, type: !266, isLocal: false, isDefinition: true)
!266 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 20, size: 256, elements: !267)
!267 = !{!268, !269, !270, !279}
!268 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !266, file: !3, line: 21, baseType: !46, size: 64)
!269 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !266, file: !3, line: 22, baseType: !37, size: 64, offset: 64)
!270 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !266, file: !3, line: 23, baseType: !271, size: 64, offset: 128)
!271 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !272, size: 64)
!272 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "map_locked_value", file: !3, line: 15, size: 128, elements: !273)
!273 = !{!274, !275}
!274 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !272, file: !3, line: 16, baseType: !53, size: 64)
!275 = !DIDerivedType(tag: DW_TAG_member, name: "lock", scope: !272, file: !3, line: 17, baseType: !276, size: 32, offset: 64)
!276 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_spin_lock", file: !6, line: 6186, size: 32, elements: !277)
!277 = !{!278}
!278 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !276, file: !6, line: 6187, baseType: !38, size: 32)
!279 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !266, file: !3, line: 24, baseType: !32, size: 64, offset: 192)
!280 = !DIGlobalVariableExpression(var: !281, expr: !DIExpression())
!281 = distinct !DIGlobalVariable(name: "inner_map_array1", scope: !2, file: !3, line: 32, type: !43, isLocal: false, isDefinition: true)
!282 = !DIGlobalVariableExpression(var: !283, expr: !DIExpression())
!283 = distinct !DIGlobalVariable(name: "inner_map_array2", scope: !2, file: !3, line: 32, type: !43, isLocal: false, isDefinition: true)
!284 = !DIGlobalVariableExpression(var: !285, expr: !DIExpression())
!285 = distinct !DIGlobalVariable(name: "inner_map_array3", scope: !2, file: !3, line: 32, type: !43, isLocal: false, isDefinition: true)
!286 = !DIGlobalVariableExpression(var: !287, expr: !DIExpression())
!287 = distinct !DIGlobalVariable(name: "inner_map_array4", scope: !2, file: !3, line: 33, type: !43, isLocal: false, isDefinition: true)
!288 = !DIGlobalVariableExpression(var: !289, expr: !DIExpression())
!289 = distinct !DIGlobalVariable(name: "inner_map_array5", scope: !2, file: !3, line: 33, type: !43, isLocal: false, isDefinition: true)
!290 = !DIGlobalVariableExpression(var: !291, expr: !DIExpression())
!291 = distinct !DIGlobalVariable(name: "inner_map_array6", scope: !2, file: !3, line: 33, type: !43, isLocal: false, isDefinition: true)
!292 = !DIGlobalVariableExpression(var: !293, expr: !DIExpression())
!293 = distinct !DIGlobalVariable(name: "inner_map_array7", scope: !2, file: !3, line: 33, type: !43, isLocal: false, isDefinition: true)
!294 = !DIGlobalVariableExpression(var: !295, expr: !DIExpression())
!295 = distinct !DIGlobalVariable(name: "inner_map_queue0", scope: !2, file: !3, line: 49, type: !68, isLocal: false, isDefinition: true)
!296 = !DIGlobalVariableExpression(var: !297, expr: !DIExpression())
!297 = distinct !DIGlobalVariable(name: "inner_map_queue1", scope: !2, file: !3, line: 49, type: !68, isLocal: false, isDefinition: true)
!298 = !DIGlobalVariableExpression(var: !299, expr: !DIExpression())
!299 = distinct !DIGlobalVariable(name: "inner_map_queue2", scope: !2, file: !3, line: 49, type: !68, isLocal: false, isDefinition: true)
!300 = !DIGlobalVariableExpression(var: !301, expr: !DIExpression())
!301 = distinct !DIGlobalVariable(name: "inner_map_queue3", scope: !2, file: !3, line: 49, type: !68, isLocal: false, isDefinition: true)
!302 = !DIGlobalVariableExpression(var: !303, expr: !DIExpression())
!303 = distinct !DIGlobalVariable(name: "inner_map_queue4", scope: !2, file: !3, line: 50, type: !68, isLocal: false, isDefinition: true)
!304 = !DIGlobalVariableExpression(var: !305, expr: !DIExpression())
!305 = distinct !DIGlobalVariable(name: "inner_map_queue5", scope: !2, file: !3, line: 50, type: !68, isLocal: false, isDefinition: true)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(name: "inner_map_queue6", scope: !2, file: !3, line: 50, type: !68, isLocal: false, isDefinition: true)
!308 = !DIGlobalVariableExpression(var: !309, expr: !DIExpression())
!309 = distinct !DIGlobalVariable(name: "inner_map_queue7", scope: !2, file: !3, line: 50, type: !68, isLocal: false, isDefinition: true)
!310 = !DIGlobalVariableExpression(var: !311, expr: !DIExpression())
!311 = distinct !DIGlobalVariable(name: "common_array", scope: !2, file: !3, line: 68, type: !312, isLocal: false, isDefinition: true)
!312 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 63, size: 256, elements: !313)
!313 = !{!314, !315, !316, !317}
!314 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !312, file: !3, line: 64, baseType: !46, size: 64)
!315 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !312, file: !3, line: 65, baseType: !37, size: 64, offset: 64)
!316 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !312, file: !3, line: 66, baseType: !52, size: 64, offset: 128)
!317 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !312, file: !3, line: 67, baseType: !32, size: 64, offset: 192)
!318 = !DIGlobalVariableExpression(var: !319, expr: !DIExpression())
!319 = distinct !DIGlobalVariable(name: "percpu_array", scope: !2, file: !3, line: 75, type: !320, isLocal: false, isDefinition: true)
!320 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 70, size: 256, elements: !321)
!321 = !{!322, !327, !328, !329}
!322 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !320, file: !3, line: 71, baseType: !323, size: 64)
!323 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !324, size: 64)
!324 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 192, elements: !325)
!325 = !{!326}
!326 = !DISubrange(count: 6)
!327 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !320, file: !3, line: 72, baseType: !37, size: 64, offset: 64)
!328 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !320, file: !3, line: 73, baseType: !52, size: 64, offset: 128)
!329 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !320, file: !3, line: 74, baseType: !32, size: 64, offset: 192)
!330 = !DIGlobalVariableExpression(var: !331, expr: !DIExpression())
!331 = distinct !DIGlobalVariable(name: "counter_array", scope: !2, file: !3, line: 82, type: !332, isLocal: false, isDefinition: true)
!332 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 77, size: 256, elements: !333)
!333 = !{!334, !335, !336, !337}
!334 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !332, file: !3, line: 78, baseType: !46, size: 64)
!335 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !332, file: !3, line: 79, baseType: !37, size: 64, offset: 64)
!336 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !332, file: !3, line: 80, baseType: !52, size: 64, offset: 128)
!337 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !332, file: !3, line: 81, baseType: !32, size: 64, offset: 192)
!338 = !DIGlobalVariableExpression(var: !339, expr: !DIExpression())
!339 = distinct !DIGlobalVariable(name: "time_array", scope: !2, file: !3, line: 89, type: !340, isLocal: false, isDefinition: true)
!340 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 84, size: 256, elements: !341)
!341 = !{!342, !343, !344, !345}
!342 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !340, file: !3, line: 85, baseType: !46, size: 64)
!343 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !340, file: !3, line: 86, baseType: !37, size: 64, offset: 64)
!344 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !340, file: !3, line: 87, baseType: !52, size: 64, offset: 128)
!345 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !340, file: !3, line: 88, baseType: !32, size: 64, offset: 192)
!346 = !DIGlobalVariableExpression(var: !347, expr: !DIExpression())
!347 = distinct !DIGlobalVariable(name: "common_hash", scope: !2, file: !3, line: 104, type: !348, isLocal: false, isDefinition: true)
!348 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 99, size: 256, elements: !349)
!349 = !{!350, !355, !356, !357}
!350 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !348, file: !3, line: 100, baseType: !351, size: 64)
!351 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !352, size: 64)
!352 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 32, elements: !353)
!353 = !{!354}
!354 = !DISubrange(count: 1)
!355 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !348, file: !3, line: 101, baseType: !91, size: 64, offset: 64)
!356 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !348, file: !3, line: 102, baseType: !52, size: 64, offset: 128)
!357 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !348, file: !3, line: 103, baseType: !32, size: 64, offset: 192)
!358 = !DIGlobalVariableExpression(var: !359, expr: !DIExpression())
!359 = distinct !DIGlobalVariable(name: "inner_array_hash0", scope: !2, file: !3, line: 111, type: !99, isLocal: false, isDefinition: true)
!360 = !DIGlobalVariableExpression(var: !361, expr: !DIExpression())
!361 = distinct !DIGlobalVariable(name: "inner_array_hash1", scope: !2, file: !3, line: 112, type: !99, isLocal: false, isDefinition: true)
!362 = !DIGlobalVariableExpression(var: !363, expr: !DIExpression())
!363 = distinct !DIGlobalVariable(name: "inner_array_hash2", scope: !2, file: !3, line: 113, type: !99, isLocal: false, isDefinition: true)
!364 = !DIGlobalVariableExpression(var: !365, expr: !DIExpression())
!365 = distinct !DIGlobalVariable(name: "inner_array_hash3", scope: !2, file: !3, line: 114, type: !99, isLocal: false, isDefinition: true)
!366 = !DIGlobalVariableExpression(var: !367, expr: !DIExpression())
!367 = distinct !DIGlobalVariable(name: "inner_array_hash4", scope: !2, file: !3, line: 115, type: !99, isLocal: false, isDefinition: true)
!368 = !DIGlobalVariableExpression(var: !369, expr: !DIExpression())
!369 = distinct !DIGlobalVariable(name: "inner_array_hash5", scope: !2, file: !3, line: 116, type: !99, isLocal: false, isDefinition: true)
!370 = !DIGlobalVariableExpression(var: !371, expr: !DIExpression())
!371 = distinct !DIGlobalVariable(name: "inner_array_hash6", scope: !2, file: !3, line: 117, type: !99, isLocal: false, isDefinition: true)
!372 = !DIGlobalVariableExpression(var: !373, expr: !DIExpression())
!373 = distinct !DIGlobalVariable(name: "inner_array_hash7", scope: !2, file: !3, line: 118, type: !99, isLocal: false, isDefinition: true)
!374 = !DIGlobalVariableExpression(var: !375, expr: !DIExpression())
!375 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !376, line: 206, type: !377, isLocal: true, isDefinition: true)
!376 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/benchmark", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!377 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !378, size: 64)
!378 = !DISubroutineType(types: !379)
!379 = !{!38}
!380 = !DIGlobalVariableExpression(var: !381, expr: !DIExpression())
!381 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !376, line: 177, type: !382, isLocal: true, isDefinition: true)
!382 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !383, size: 64)
!383 = !DISubroutineType(types: !384)
!384 = !{!385, !386, !38, null}
!385 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!386 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !131, size: 64)
!387 = !DIGlobalVariableExpression(var: !388, expr: !DIExpression())
!388 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !376, line: 114, type: !389, isLocal: true, isDefinition: true)
!389 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !390, size: 64)
!390 = !DISubroutineType(types: !391)
!391 = !{!53}
!392 = !DIGlobalVariableExpression(var: !393, expr: !DIExpression())
!393 = distinct !DIGlobalVariable(name: "____fmt", scope: !394, file: !3, line: 384, type: !130, isLocal: true, isDefinition: true)
!394 = distinct !DISubprogram(name: "lookup_map_of_maps_queue", scope: !3, file: !3, line: 379, type: !395, scopeLine: 379, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !397)
!395 = !DISubroutineType(types: !396)
!396 = !{!53, !28, !53}
!397 = !{!398, !399, !400, !401}
!398 = !DILocalVariable(name: "key", arg: 1, scope: !394, file: !3, line: 379, type: !28)
!399 = !DILocalVariable(name: "counter", arg: 2, scope: !394, file: !3, line: 379, type: !53)
!400 = !DILocalVariable(name: "map", scope: !394, file: !3, line: 381, type: !67)
!401 = !DILocalVariable(name: "value", scope: !394, file: !3, line: 403, type: !53)
!402 = !DIGlobalVariableExpression(var: !403, expr: !DIExpression())
!403 = distinct !DIGlobalVariable(name: "____fmt", scope: !394, file: !3, line: 406, type: !254, isLocal: true, isDefinition: true)
!404 = !DIGlobalVariableExpression(var: !405, expr: !DIExpression())
!405 = distinct !DIGlobalVariable(name: "____fmt", scope: !394, file: !3, line: 411, type: !406, isLocal: true, isDefinition: true)
!406 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 304, elements: !407)
!407 = !{!408}
!408 = !DISubrange(count: 38)
!409 = !DIGlobalVariableExpression(var: !410, expr: !DIExpression())
!410 = distinct !DIGlobalVariable(name: "bpf_map_peek_elem", scope: !2, file: !376, line: 2298, type: !411, isLocal: true, isDefinition: true)
!411 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !412, size: 64)
!412 = !DISubroutineType(types: !413)
!413 = !{!385, !414, !414}
!414 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!415 = !DIGlobalVariableExpression(var: !416, expr: !DIExpression())
!416 = distinct !DIGlobalVariable(name: "bpf_map_push_elem", scope: !2, file: !376, line: 2278, type: !417, isLocal: true, isDefinition: true)
!417 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !418, size: 64)
!418 = !DISubroutineType(types: !419)
!419 = !{!385, !414, !420, !53}
!420 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !421, size: 64)
!421 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!422 = !DIGlobalVariableExpression(var: !423, expr: !DIExpression())
!423 = distinct !DIGlobalVariable(name: "____fmt", scope: !424, file: !3, line: 462, type: !130, isLocal: true, isDefinition: true)
!424 = distinct !DISubprogram(name: "lookup_map_of_maps_array", scope: !3, file: !3, line: 457, type: !425, scopeLine: 457, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !427)
!425 = !DISubroutineType(types: !426)
!426 = !{!28, !28}
!427 = !{!428, !429, !430, !431}
!428 = !DILocalVariable(name: "key", arg: 1, scope: !424, file: !3, line: 457, type: !28)
!429 = !DILocalVariable(name: "map", scope: !424, file: !3, line: 459, type: !42)
!430 = !DILocalVariable(name: "inner_map_key", scope: !424, file: !3, line: 466, type: !28)
!431 = !DILocalVariable(name: "value", scope: !424, file: !3, line: 467, type: !52)
!432 = !DIGlobalVariableExpression(var: !433, expr: !DIExpression())
!433 = distinct !DIGlobalVariable(name: "____fmt", scope: !434, file: !3, line: 530, type: !162, isLocal: true, isDefinition: true)
!434 = distinct !DISubprogram(name: "lookup_lock_map", scope: !3, file: !3, line: 525, type: !425, scopeLine: 525, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !435)
!435 = !{!436, !437}
!436 = !DILocalVariable(name: "key", arg: 1, scope: !434, file: !3, line: 525, type: !28)
!437 = !DILocalVariable(name: "lock_value", scope: !434, file: !3, line: 527, type: !271)
!438 = !DIGlobalVariableExpression(var: !439, expr: !DIExpression())
!439 = distinct !DIGlobalVariable(name: "bpf_spin_lock", scope: !2, file: !376, line: 2404, type: !440, isLocal: true, isDefinition: true)
!440 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !441, size: 64)
!441 = !DISubroutineType(types: !442)
!442 = !{!385, !443}
!443 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !276, size: 64)
!444 = !DIGlobalVariableExpression(var: !445, expr: !DIExpression())
!445 = distinct !DIGlobalVariable(name: "bpf_spin_unlock", scope: !2, file: !376, line: 2415, type: !440, isLocal: true, isDefinition: true)
!446 = !DIGlobalVariableExpression(var: !447, expr: !DIExpression())
!447 = distinct !DIGlobalVariable(name: "____fmt", scope: !448, file: !3, line: 577, type: !130, isLocal: true, isDefinition: true)
!448 = distinct !DISubprogram(name: "lookup_map_of_maps_hash", scope: !3, file: !3, line: 571, type: !449, scopeLine: 571, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !451)
!449 = !DISubroutineType(types: !450)
!450 = !{!28, !53}
!451 = !{!452, !453, !454, !455}
!452 = !DILocalVariable(name: "key", arg: 1, scope: !448, file: !3, line: 571, type: !53)
!453 = !DILocalVariable(name: "hash_map_key", scope: !448, file: !3, line: 573, type: !92)
!454 = !DILocalVariable(name: "inner", scope: !448, file: !3, line: 574, type: !98)
!455 = !DILocalVariable(name: "inner_elem", scope: !448, file: !3, line: 594, type: !104)
!456 = !DIGlobalVariableExpression(var: !457, expr: !DIExpression())
!457 = distinct !DIGlobalVariable(name: "____fmt", scope: !448, file: !3, line: 596, type: !458, isLocal: true, isDefinition: true)
!458 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 256, elements: !79)
!459 = !DIGlobalVariableExpression(var: !460, expr: !DIExpression())
!460 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !376, line: 56, type: !461, isLocal: true, isDefinition: true)
!461 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !462, size: 64)
!462 = !DISubroutineType(types: !463)
!463 = !{!414, !414, !420}
!464 = !DIGlobalVariableExpression(var: !465, expr: !DIExpression())
!465 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !376, line: 78, type: !466, isLocal: true, isDefinition: true)
!466 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !467, size: 64)
!467 = !DISubroutineType(types: !468)
!468 = !{!385, !414, !420, !420, !53}
!469 = !{i32 7, !"Dwarf Version", i32 5}
!470 = !{i32 2, !"Debug Info Version", i32 3}
!471 = !{i32 1, !"wchar_size", i32 4}
!472 = !{i32 7, !"frame-pointer", i32 2}
!473 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!474 = !DILocation(line: 0, scope: !111)
!475 = !DILocation(line: 255, column: 15, scope: !111)
!476 = !DILocation(line: 0, scope: !477, inlinedAt: !484)
!477 = distinct !DISubprogram(name: "update_counter", scope: !3, file: !3, line: 214, type: !478, scopeLine: 214, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !480)
!478 = !DISubroutineType(types: !479)
!479 = !{!53, !28}
!480 = !{!481, !482, !483}
!481 = !DILocalVariable(name: "key_cpu", arg: 1, scope: !477, file: !3, line: 214, type: !28)
!482 = !DILocalVariable(name: "value", scope: !477, file: !3, line: 215, type: !52)
!483 = !DILocalVariable(name: "new_value", scope: !477, file: !3, line: 219, type: !53)
!484 = distinct !DILocation(line: 258, column: 9, scope: !485)
!485 = distinct !DILexicalBlock(scope: !111, file: !3, line: 258, column: 8)
!486 = !{!487, !487, i64 0}
!487 = !{!"int", !488, i64 0}
!488 = !{!"omnipotent char", !489, i64 0}
!489 = !{!"Simple C/C++ TBAA"}
!490 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !484)
!491 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !484)
!492 = distinct !DILexicalBlock(scope: !477, file: !3, line: 216, column: 8)
!493 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !484)
!494 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !484)
!495 = !DILocation(line: 258, column: 8, scope: !111)
!496 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !484)
!497 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !484)
!498 = !{!499, !499, i64 0}
!499 = !{!"long long", !488, i64 0}
!500 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !484)
!501 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !484)
!502 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !484)
!503 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !484)
!504 = !DILocation(line: 258, column: 9, scope: !485)
!505 = !DILocation(line: 259, column: 9, scope: !506)
!506 = distinct !DILexicalBlock(scope: !507, file: !3, line: 259, column: 9)
!507 = distinct !DILexicalBlock(scope: !485, file: !3, line: 258, column: 30)
!508 = !DILocation(line: 260, column: 5, scope: !507)
!509 = !DILocation(line: 262, column: 26, scope: !111)
!510 = !DILocation(line: 0, scope: !128)
!511 = !DILocation(line: 265, column: 5, scope: !128)
!512 = !DILocation(line: 268, column: 25, scope: !111)
!513 = !DILocation(line: 0, scope: !514, inlinedAt: !523)
!514 = distinct !DISubprogram(name: "update_time", scope: !3, file: !3, line: 225, type: !515, scopeLine: 225, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !517)
!515 = !DISubroutineType(types: !516)
!516 = !{!28, !53, !53, !28}
!517 = !{!518, !519, !520, !521, !522}
!518 = !DILocalVariable(name: "arrival_time", arg: 1, scope: !514, file: !3, line: 225, type: !53)
!519 = !DILocalVariable(name: "finish_time", arg: 2, scope: !514, file: !3, line: 225, type: !53)
!520 = !DILocalVariable(name: "key_cpu", arg: 3, scope: !514, file: !3, line: 225, type: !28)
!521 = !DILocalVariable(name: "value", scope: !514, file: !3, line: 226, type: !52)
!522 = !DILocalVariable(name: "new_value", scope: !514, file: !3, line: 230, type: !53)
!523 = distinct !DILocation(line: 269, column: 9, scope: !524)
!524 = distinct !DILexicalBlock(scope: !111, file: !3, line: 269, column: 8)
!525 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !523)
!526 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !523)
!527 = distinct !DILexicalBlock(scope: !514, file: !3, line: 227, column: 8)
!528 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !523)
!529 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !523)
!530 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !523)
!531 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !523)
!532 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !523)
!533 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !523)
!534 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !523)
!535 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !523)
!536 = !DILocation(line: 269, column: 8, scope: !111)
!537 = !DILocation(line: 0, scope: !538, inlinedAt: !545)
!538 = distinct !DISubprogram(name: "lookup_map", scope: !3, file: !3, line: 236, type: !539, scopeLine: 236, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !541)
!539 = !DISubroutineType(types: !540)
!540 = !{!28, !28, !414}
!541 = !{!542, !543, !544}
!542 = !DILocalVariable(name: "key", arg: 1, scope: !538, file: !3, line: 236, type: !28)
!543 = !DILocalVariable(name: "map_pointer", arg: 2, scope: !538, file: !3, line: 236, type: !414)
!544 = !DILocalVariable(name: "value", scope: !538, file: !3, line: 237, type: !52)
!545 = distinct !DILocation(line: 266, column: 9, scope: !546)
!546 = distinct !DILexicalBlock(scope: !128, file: !3, line: 265, column: 5)
!547 = !DILocation(line: 237, column: 21, scope: !538, inlinedAt: !545)
!548 = !DILocation(line: 239, column: 9, scope: !549, inlinedAt: !545)
!549 = distinct !DILexicalBlock(scope: !538, file: !3, line: 239, column: 8)
!550 = !DILocation(line: 239, column: 8, scope: !538, inlinedAt: !545)
!551 = !DILocation(line: 244, column: 12, scope: !538, inlinedAt: !545)
!552 = !DILocation(line: 249, column: 5, scope: !538, inlinedAt: !545)
!553 = !DILocation(line: 250, column: 1, scope: !538, inlinedAt: !545)
!554 = !DILocation(line: 265, column: 30, scope: !546)
!555 = !DILocation(line: 265, column: 22, scope: !546)
!556 = distinct !{!556, !511, !557, !558}
!557 = !DILocation(line: 266, column: 38, scope: !128)
!558 = !{!"llvm.loop.mustprogress"}
!559 = !DILocation(line: 270, column: 9, scope: !560)
!560 = distinct !DILexicalBlock(scope: !561, file: !3, line: 270, column: 9)
!561 = distinct !DILexicalBlock(scope: !524, file: !3, line: 269, column: 54)
!562 = !DILocation(line: 271, column: 5, scope: !561)
!563 = !DILocation(line: 273, column: 5, scope: !111)
!564 = !DILocation(line: 0, scope: !142)
!565 = !DILocation(line: 282, column: 15, scope: !142)
!566 = !DILocation(line: 0, scope: !477, inlinedAt: !567)
!567 = distinct !DILocation(line: 285, column: 9, scope: !568)
!568 = distinct !DILexicalBlock(scope: !142, file: !3, line: 285, column: 8)
!569 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !567)
!570 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !567)
!571 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !567)
!572 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !567)
!573 = !DILocation(line: 285, column: 8, scope: !142)
!574 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !567)
!575 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !567)
!576 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !567)
!577 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !567)
!578 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !567)
!579 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !567)
!580 = !DILocation(line: 285, column: 9, scope: !568)
!581 = !DILocation(line: 286, column: 9, scope: !582)
!582 = distinct !DILexicalBlock(scope: !583, file: !3, line: 286, column: 9)
!583 = distinct !DILexicalBlock(scope: !568, file: !3, line: 285, column: 30)
!584 = !DILocation(line: 287, column: 5, scope: !583)
!585 = !DILocation(line: 289, column: 26, scope: !142)
!586 = !DILocation(line: 0, scope: !148)
!587 = !DILocation(line: 292, column: 5, scope: !148)
!588 = !DILocation(line: 295, column: 25, scope: !142)
!589 = !DILocation(line: 0, scope: !514, inlinedAt: !590)
!590 = distinct !DILocation(line: 296, column: 9, scope: !591)
!591 = distinct !DILexicalBlock(scope: !142, file: !3, line: 296, column: 8)
!592 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !590)
!593 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !590)
!594 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !590)
!595 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !590)
!596 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !590)
!597 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !590)
!598 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !590)
!599 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !590)
!600 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !590)
!601 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !590)
!602 = !DILocation(line: 296, column: 8, scope: !142)
!603 = !DILocation(line: 0, scope: !538, inlinedAt: !604)
!604 = distinct !DILocation(line: 293, column: 9, scope: !605)
!605 = distinct !DILexicalBlock(scope: !148, file: !3, line: 292, column: 5)
!606 = !DILocation(line: 237, column: 21, scope: !538, inlinedAt: !604)
!607 = !DILocation(line: 239, column: 9, scope: !549, inlinedAt: !604)
!608 = !DILocation(line: 239, column: 8, scope: !538, inlinedAt: !604)
!609 = !DILocation(line: 244, column: 12, scope: !538, inlinedAt: !604)
!610 = !DILocation(line: 249, column: 5, scope: !538, inlinedAt: !604)
!611 = !DILocation(line: 250, column: 1, scope: !538, inlinedAt: !604)
!612 = !DILocation(line: 292, column: 30, scope: !605)
!613 = !DILocation(line: 292, column: 22, scope: !605)
!614 = distinct !{!614, !587, !615, !558}
!615 = !DILocation(line: 293, column: 36, scope: !148)
!616 = !DILocation(line: 297, column: 9, scope: !617)
!617 = distinct !DILexicalBlock(scope: !618, file: !3, line: 297, column: 9)
!618 = distinct !DILexicalBlock(scope: !591, file: !3, line: 296, column: 54)
!619 = !DILocation(line: 298, column: 5, scope: !618)
!620 = !DILocation(line: 300, column: 5, scope: !142)
!621 = !DILocation(line: 0, scope: !154)
!622 = !DILocation(line: 306, column: 15, scope: !154)
!623 = !DILocation(line: 0, scope: !477, inlinedAt: !624)
!624 = distinct !DILocation(line: 309, column: 9, scope: !625)
!625 = distinct !DILexicalBlock(scope: !154, file: !3, line: 309, column: 8)
!626 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !624)
!627 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !624)
!628 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !624)
!629 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !624)
!630 = !DILocation(line: 309, column: 8, scope: !154)
!631 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !624)
!632 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !624)
!633 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !624)
!634 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !624)
!635 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !624)
!636 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !624)
!637 = !DILocation(line: 309, column: 9, scope: !625)
!638 = !DILocation(line: 310, column: 9, scope: !639)
!639 = distinct !DILexicalBlock(scope: !640, file: !3, line: 310, column: 9)
!640 = distinct !DILexicalBlock(scope: !625, file: !3, line: 309, column: 30)
!641 = !DILocation(line: 311, column: 5, scope: !640)
!642 = !DILocation(line: 313, column: 26, scope: !154)
!643 = !DILocation(line: 0, scope: !160)
!644 = !DILocation(line: 316, column: 5, scope: !160)
!645 = !DILocation(line: 319, column: 25, scope: !154)
!646 = !DILocation(line: 0, scope: !514, inlinedAt: !647)
!647 = distinct !DILocation(line: 320, column: 9, scope: !648)
!648 = distinct !DILexicalBlock(scope: !154, file: !3, line: 320, column: 8)
!649 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !647)
!650 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !647)
!651 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !647)
!652 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !647)
!653 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !647)
!654 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !647)
!655 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !647)
!656 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !647)
!657 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !647)
!658 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !647)
!659 = !DILocation(line: 320, column: 8, scope: !154)
!660 = !DILocation(line: 0, scope: !538, inlinedAt: !661)
!661 = distinct !DILocation(line: 317, column: 9, scope: !662)
!662 = distinct !DILexicalBlock(scope: !160, file: !3, line: 316, column: 5)
!663 = !DILocation(line: 237, column: 21, scope: !538, inlinedAt: !661)
!664 = !DILocation(line: 239, column: 9, scope: !549, inlinedAt: !661)
!665 = !DILocation(line: 239, column: 8, scope: !538, inlinedAt: !661)
!666 = !DILocation(line: 244, column: 12, scope: !538, inlinedAt: !661)
!667 = !DILocation(line: 249, column: 5, scope: !538, inlinedAt: !661)
!668 = !DILocation(line: 250, column: 1, scope: !538, inlinedAt: !661)
!669 = !DILocation(line: 316, column: 30, scope: !662)
!670 = !DILocation(line: 316, column: 22, scope: !662)
!671 = distinct !{!671, !644, !672, !558}
!672 = !DILocation(line: 317, column: 36, scope: !160)
!673 = !DILocation(line: 321, column: 9, scope: !674)
!674 = distinct !DILexicalBlock(scope: !675, file: !3, line: 321, column: 9)
!675 = distinct !DILexicalBlock(scope: !648, file: !3, line: 320, column: 54)
!676 = !DILocation(line: 322, column: 5, scope: !675)
!677 = !DILocation(line: 324, column: 5, scope: !154)
!678 = !DILocation(line: 0, scope: !172)
!679 = !DILocation(line: 332, column: 15, scope: !172)
!680 = !DILocation(line: 0, scope: !477, inlinedAt: !681)
!681 = distinct !DILocation(line: 339, column: 9, scope: !682)
!682 = distinct !DILexicalBlock(scope: !172, file: !3, line: 339, column: 8)
!683 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !681)
!684 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !681)
!685 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !681)
!686 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !681)
!687 = !DILocation(line: 339, column: 8, scope: !172)
!688 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !681)
!689 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !681)
!690 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !681)
!691 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !681)
!692 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !681)
!693 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !681)
!694 = !DILocation(line: 339, column: 9, scope: !682)
!695 = !DILocation(line: 340, column: 9, scope: !696)
!696 = distinct !DILexicalBlock(scope: !697, file: !3, line: 340, column: 9)
!697 = distinct !DILexicalBlock(scope: !682, file: !3, line: 339, column: 30)
!698 = !DILocation(line: 341, column: 5, scope: !697)
!699 = !DILocation(line: 345, column: 26, scope: !172)
!700 = !DILocation(line: 371, column: 25, scope: !172)
!701 = !DILocation(line: 0, scope: !514, inlinedAt: !702)
!702 = distinct !DILocation(line: 372, column: 9, scope: !703)
!703 = distinct !DILexicalBlock(scope: !172, file: !3, line: 372, column: 8)
!704 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !702)
!705 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !702)
!706 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !702)
!707 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !702)
!708 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !702)
!709 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !702)
!710 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !702)
!711 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !702)
!712 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !702)
!713 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !702)
!714 = !DILocation(line: 372, column: 8, scope: !172)
!715 = !DILocation(line: 373, column: 9, scope: !716)
!716 = distinct !DILexicalBlock(scope: !717, file: !3, line: 373, column: 9)
!717 = distinct !DILexicalBlock(scope: !703, file: !3, line: 372, column: 54)
!718 = !DILocation(line: 374, column: 5, scope: !717)
!719 = !DILocation(line: 376, column: 5, scope: !172)
!720 = !DILocation(line: 0, scope: !182)
!721 = !DILocation(line: 436, column: 15, scope: !182)
!722 = !DILocation(line: 0, scope: !477, inlinedAt: !723)
!723 = distinct !DILocation(line: 439, column: 21, scope: !182)
!724 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !723)
!725 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !723)
!726 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !723)
!727 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !723)
!728 = !DILocation(line: 440, column: 8, scope: !182)
!729 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !723)
!730 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !723)
!731 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !723)
!732 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !723)
!733 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !723)
!734 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !723)
!735 = !DILocation(line: 440, column: 16, scope: !736)
!736 = distinct !DILexicalBlock(scope: !182, file: !3, line: 440, column: 8)
!737 = !DILocation(line: 441, column: 9, scope: !738)
!738 = distinct !DILexicalBlock(scope: !739, file: !3, line: 441, column: 9)
!739 = distinct !DILexicalBlock(scope: !736, file: !3, line: 440, column: 22)
!740 = !DILocation(line: 442, column: 5, scope: !739)
!741 = !DILocation(line: 444, column: 26, scope: !182)
!742 = !DILocation(line: 0, scope: !189)
!743 = !DILocation(line: 446, column: 5, scope: !189)
!744 = !DILocation(line: 449, column: 25, scope: !182)
!745 = !DILocation(line: 0, scope: !514, inlinedAt: !746)
!746 = distinct !DILocation(line: 450, column: 9, scope: !747)
!747 = distinct !DILexicalBlock(scope: !182, file: !3, line: 450, column: 8)
!748 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !746)
!749 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !746)
!750 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !746)
!751 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !746)
!752 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !746)
!753 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !746)
!754 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !746)
!755 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !746)
!756 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !746)
!757 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !746)
!758 = !DILocation(line: 450, column: 8, scope: !182)
!759 = !DILocation(line: 0, scope: !394, inlinedAt: !760)
!760 = distinct !DILocation(line: 447, column: 9, scope: !761)
!761 = distinct !DILexicalBlock(scope: !189, file: !3, line: 446, column: 5)
!762 = !DILocation(line: 381, column: 39, scope: !394, inlinedAt: !760)
!763 = !DILocation(line: 383, column: 13, scope: !764, inlinedAt: !760)
!764 = distinct !DILexicalBlock(scope: !394, file: !3, line: 383, column: 12)
!765 = !DILocation(line: 383, column: 12, scope: !394, inlinedAt: !760)
!766 = !DILocation(line: 384, column: 13, scope: !767, inlinedAt: !760)
!767 = distinct !DILexicalBlock(scope: !768, file: !3, line: 384, column: 13)
!768 = distinct !DILexicalBlock(scope: !764, file: !3, line: 383, column: 18)
!769 = !DILocation(line: 385, column: 13, scope: !768, inlinedAt: !760)
!770 = !DILocation(line: 403, column: 9, scope: !394, inlinedAt: !760)
!771 = !DILocation(line: 405, column: 12, scope: !772, inlinedAt: !760)
!772 = distinct !DILexicalBlock(scope: !394, file: !3, line: 405, column: 12)
!773 = !DILocation(line: 405, column: 43, scope: !772, inlinedAt: !760)
!774 = !DILocation(line: 405, column: 12, scope: !394, inlinedAt: !760)
!775 = !DILocation(line: 406, column: 13, scope: !776, inlinedAt: !760)
!776 = distinct !DILexicalBlock(scope: !777, file: !3, line: 406, column: 13)
!777 = distinct !DILexicalBlock(scope: !772, file: !3, line: 405, column: 48)
!778 = !DILocation(line: 407, column: 13, scope: !777, inlinedAt: !760)
!779 = !DILocation(line: 410, column: 12, scope: !780, inlinedAt: !760)
!780 = distinct !DILexicalBlock(scope: !394, file: !3, line: 410, column: 12)
!781 = !DILocation(line: 410, column: 56, scope: !780, inlinedAt: !760)
!782 = !DILocation(line: 410, column: 12, scope: !394, inlinedAt: !760)
!783 = !DILocation(line: 411, column: 13, scope: !784, inlinedAt: !760)
!784 = distinct !DILexicalBlock(scope: !785, file: !3, line: 411, column: 13)
!785 = distinct !DILexicalBlock(scope: !780, file: !3, line: 410, column: 61)
!786 = !DILocation(line: 412, column: 13, scope: !785, inlinedAt: !760)
!787 = !DILocation(line: 431, column: 1, scope: !394, inlinedAt: !760)
!788 = !DILocation(line: 446, column: 30, scope: !761)
!789 = !DILocation(line: 446, column: 22, scope: !761)
!790 = distinct !{!790, !743, !791, !558}
!791 = !DILocation(line: 447, column: 53, scope: !189)
!792 = !DILocation(line: 451, column: 9, scope: !793)
!793 = distinct !DILexicalBlock(scope: !794, file: !3, line: 451, column: 9)
!794 = distinct !DILexicalBlock(scope: !747, file: !3, line: 450, column: 54)
!795 = !DILocation(line: 452, column: 5, scope: !794)
!796 = !DILocation(line: 454, column: 5, scope: !182)
!797 = !DILocation(line: 0, scope: !195)
!798 = !DILocation(line: 482, column: 15, scope: !195)
!799 = !DILocation(line: 0, scope: !477, inlinedAt: !800)
!800 = distinct !DILocation(line: 484, column: 9, scope: !801)
!801 = distinct !DILexicalBlock(scope: !195, file: !3, line: 484, column: 8)
!802 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !800)
!803 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !800)
!804 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !800)
!805 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !800)
!806 = !DILocation(line: 484, column: 8, scope: !195)
!807 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !800)
!808 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !800)
!809 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !800)
!810 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !800)
!811 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !800)
!812 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !800)
!813 = !DILocation(line: 484, column: 9, scope: !801)
!814 = !DILocation(line: 485, column: 9, scope: !815)
!815 = distinct !DILexicalBlock(scope: !816, file: !3, line: 485, column: 9)
!816 = distinct !DILexicalBlock(scope: !801, file: !3, line: 484, column: 30)
!817 = !DILocation(line: 486, column: 5, scope: !816)
!818 = !DILocation(line: 488, column: 26, scope: !195)
!819 = !DILocation(line: 0, scope: !201)
!820 = !DILocation(line: 490, column: 5, scope: !201)
!821 = !DILocation(line: 493, column: 25, scope: !195)
!822 = !DILocation(line: 0, scope: !514, inlinedAt: !823)
!823 = distinct !DILocation(line: 494, column: 9, scope: !824)
!824 = distinct !DILexicalBlock(scope: !195, file: !3, line: 494, column: 8)
!825 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !823)
!826 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !823)
!827 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !823)
!828 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !823)
!829 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !823)
!830 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !823)
!831 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !823)
!832 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !823)
!833 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !823)
!834 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !823)
!835 = !DILocation(line: 494, column: 8, scope: !195)
!836 = !DILocation(line: 0, scope: !424, inlinedAt: !837)
!837 = distinct !DILocation(line: 491, column: 9, scope: !838)
!838 = distinct !DILexicalBlock(scope: !201, file: !3, line: 490, column: 5)
!839 = !DILocation(line: 459, column: 35, scope: !424, inlinedAt: !837)
!840 = !DILocation(line: 461, column: 9, scope: !841, inlinedAt: !837)
!841 = distinct !DILexicalBlock(scope: !424, file: !3, line: 461, column: 8)
!842 = !DILocation(line: 461, column: 8, scope: !424, inlinedAt: !837)
!843 = !DILocation(line: 462, column: 9, scope: !844, inlinedAt: !837)
!844 = distinct !DILexicalBlock(scope: !845, file: !3, line: 462, column: 9)
!845 = distinct !DILexicalBlock(scope: !841, file: !3, line: 461, column: 14)
!846 = !DILocation(line: 463, column: 9, scope: !845, inlinedAt: !837)
!847 = !DILocation(line: 466, column: 5, scope: !424, inlinedAt: !837)
!848 = !DILocation(line: 466, column: 9, scope: !424, inlinedAt: !837)
!849 = !DILocation(line: 467, column: 21, scope: !424, inlinedAt: !837)
!850 = !DILocation(line: 469, column: 9, scope: !851, inlinedAt: !837)
!851 = distinct !DILexicalBlock(scope: !424, file: !3, line: 469, column: 8)
!852 = !DILocation(line: 469, column: 8, scope: !424, inlinedAt: !837)
!853 = !DILocation(line: 472, column: 12, scope: !424, inlinedAt: !837)
!854 = !DILocation(line: 476, column: 5, scope: !424, inlinedAt: !837)
!855 = !DILocation(line: 477, column: 1, scope: !424, inlinedAt: !837)
!856 = !DILocation(line: 490, column: 30, scope: !838)
!857 = !DILocation(line: 490, column: 22, scope: !838)
!858 = distinct !{!858, !820, !859, !558}
!859 = !DILocation(line: 491, column: 37, scope: !201)
!860 = !DILocation(line: 495, column: 9, scope: !861)
!861 = distinct !DILexicalBlock(scope: !862, file: !3, line: 495, column: 9)
!862 = distinct !DILexicalBlock(scope: !824, file: !3, line: 494, column: 54)
!863 = !DILocation(line: 496, column: 5, scope: !862)
!864 = !DILocation(line: 498, column: 5, scope: !195)
!865 = !DILocation(line: 0, scope: !207)
!866 = !DILocation(line: 506, column: 26, scope: !207)
!867 = !DILocation(line: 0, scope: !213)
!868 = !DILocation(line: 509, column: 15, scope: !869)
!869 = distinct !DILexicalBlock(scope: !213, file: !3, line: 508, column: 5)
!870 = !DILocation(line: 511, column: 25, scope: !207)
!871 = !DILocation(line: 0, scope: !477, inlinedAt: !872)
!872 = distinct !DILocation(line: 513, column: 9, scope: !873)
!873 = distinct !DILexicalBlock(scope: !207, file: !3, line: 513, column: 8)
!874 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !872)
!875 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !872)
!876 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !872)
!877 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !872)
!878 = !DILocation(line: 513, column: 8, scope: !207)
!879 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !872)
!880 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !872)
!881 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !872)
!882 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !872)
!883 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !872)
!884 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !872)
!885 = !DILocation(line: 513, column: 9, scope: !873)
!886 = !DILocation(line: 514, column: 9, scope: !887)
!887 = distinct !DILexicalBlock(scope: !888, file: !3, line: 514, column: 9)
!888 = distinct !DILexicalBlock(scope: !873, file: !3, line: 513, column: 30)
!889 = !DILocation(line: 515, column: 5, scope: !888)
!890 = !DILocation(line: 0, scope: !514, inlinedAt: !891)
!891 = distinct !DILocation(line: 517, column: 9, scope: !892)
!892 = distinct !DILexicalBlock(scope: !207, file: !3, line: 517, column: 8)
!893 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !891)
!894 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !891)
!895 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !891)
!896 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !891)
!897 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !891)
!898 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !891)
!899 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !891)
!900 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !891)
!901 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !891)
!902 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !891)
!903 = !DILocation(line: 517, column: 8, scope: !207)
!904 = !DILocation(line: 518, column: 9, scope: !905)
!905 = distinct !DILexicalBlock(scope: !906, file: !3, line: 518, column: 9)
!906 = distinct !DILexicalBlock(scope: !892, file: !3, line: 517, column: 54)
!907 = !DILocation(line: 519, column: 5, scope: !906)
!908 = !DILocation(line: 521, column: 5, scope: !207)
!909 = !DILocation(line: 0, scope: !219)
!910 = !DILocation(line: 549, column: 15, scope: !219)
!911 = !DILocation(line: 0, scope: !477, inlinedAt: !912)
!912 = distinct !DILocation(line: 552, column: 9, scope: !913)
!913 = distinct !DILexicalBlock(scope: !219, file: !3, line: 552, column: 8)
!914 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !912)
!915 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !912)
!916 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !912)
!917 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !912)
!918 = !DILocation(line: 552, column: 8, scope: !219)
!919 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !912)
!920 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !912)
!921 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !912)
!922 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !912)
!923 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !912)
!924 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !912)
!925 = !DILocation(line: 552, column: 9, scope: !913)
!926 = !DILocation(line: 553, column: 9, scope: !927)
!927 = distinct !DILexicalBlock(scope: !928, file: !3, line: 553, column: 9)
!928 = distinct !DILexicalBlock(scope: !913, file: !3, line: 552, column: 30)
!929 = !DILocation(line: 554, column: 5, scope: !928)
!930 = !DILocation(line: 556, column: 26, scope: !219)
!931 = !DILocation(line: 0, scope: !225)
!932 = !DILocation(line: 559, column: 5, scope: !225)
!933 = !DILocation(line: 562, column: 25, scope: !219)
!934 = !DILocation(line: 0, scope: !514, inlinedAt: !935)
!935 = distinct !DILocation(line: 563, column: 9, scope: !936)
!936 = distinct !DILexicalBlock(scope: !219, file: !3, line: 563, column: 8)
!937 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !935)
!938 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !935)
!939 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !935)
!940 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !935)
!941 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !935)
!942 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !935)
!943 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !935)
!944 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !935)
!945 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !935)
!946 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !935)
!947 = !DILocation(line: 563, column: 8, scope: !219)
!948 = !DILocation(line: 0, scope: !434, inlinedAt: !949)
!949 = distinct !DILocation(line: 560, column: 9, scope: !950)
!950 = distinct !DILexicalBlock(scope: !225, file: !3, line: 559, column: 5)
!951 = !DILocation(line: 527, column: 43, scope: !434, inlinedAt: !949)
!952 = !DILocation(line: 529, column: 9, scope: !953, inlinedAt: !949)
!953 = distinct !DILexicalBlock(scope: !434, file: !3, line: 529, column: 8)
!954 = !DILocation(line: 529, column: 8, scope: !434, inlinedAt: !949)
!955 = !DILocation(line: 530, column: 9, scope: !956, inlinedAt: !949)
!956 = distinct !DILexicalBlock(scope: !957, file: !3, line: 530, column: 9)
!957 = distinct !DILexicalBlock(scope: !953, file: !3, line: 529, column: 21)
!958 = !DILocation(line: 531, column: 9, scope: !957, inlinedAt: !949)
!959 = !DILocation(line: 534, column: 32, scope: !434, inlinedAt: !949)
!960 = !DILocation(line: 534, column: 5, scope: !434, inlinedAt: !949)
!961 = !DILocation(line: 540, column: 23, scope: !434, inlinedAt: !949)
!962 = !{!963, !499, i64 0}
!963 = !{!"map_locked_value", !499, i64 0, !964, i64 8}
!964 = !{!"bpf_spin_lock", !487, i64 0}
!965 = !DILocation(line: 541, column: 5, scope: !434, inlinedAt: !949)
!966 = !DILocation(line: 543, column: 5, scope: !434, inlinedAt: !949)
!967 = !DILocation(line: 544, column: 1, scope: !434, inlinedAt: !949)
!968 = !DILocation(line: 559, column: 30, scope: !950)
!969 = !DILocation(line: 559, column: 22, scope: !950)
!970 = distinct !{!970, !932, !971, !558}
!971 = !DILocation(line: 560, column: 26, scope: !225)
!972 = !DILocation(line: 564, column: 9, scope: !973)
!973 = distinct !DILexicalBlock(scope: !974, file: !3, line: 564, column: 9)
!974 = distinct !DILexicalBlock(scope: !936, file: !3, line: 563, column: 54)
!975 = !DILocation(line: 565, column: 5, scope: !974)
!976 = !DILocation(line: 567, column: 5, scope: !219)
!977 = !DILocation(line: 0, scope: !231)
!978 = !DILocation(line: 610, column: 17, scope: !231)
!979 = !DILocation(line: 0, scope: !477, inlinedAt: !980)
!980 = distinct !DILocation(line: 612, column: 9, scope: !981)
!981 = distinct !DILexicalBlock(scope: !231, file: !3, line: 612, column: 8)
!982 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !980)
!983 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !980)
!984 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !980)
!985 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !980)
!986 = !DILocation(line: 612, column: 8, scope: !231)
!987 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !980)
!988 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !980)
!989 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !980)
!990 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !980)
!991 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !980)
!992 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !980)
!993 = !DILocation(line: 612, column: 9, scope: !981)
!994 = !DILocation(line: 613, column: 9, scope: !995)
!995 = distinct !DILexicalBlock(scope: !996, file: !3, line: 613, column: 9)
!996 = distinct !DILexicalBlock(scope: !981, file: !3, line: 612, column: 30)
!997 = !DILocation(line: 614, column: 5, scope: !996)
!998 = !DILocation(line: 616, column: 26, scope: !231)
!999 = !DILocation(line: 0, scope: !448, inlinedAt: !1000)
!1000 = distinct !DILocation(line: 619, column: 9, scope: !231)
!1001 = !DILocation(line: 573, column: 5, scope: !448, inlinedAt: !1000)
!1002 = !DILocation(line: 573, column: 21, scope: !448, inlinedAt: !1000)
!1003 = !DILocation(line: 573, column: 36, scope: !448, inlinedAt: !1000)
!1004 = !{!1005, !487, i64 0}
!1005 = !{!"hash_key", !487, i64 0}
!1006 = !DILocation(line: 574, column: 38, scope: !448, inlinedAt: !1000)
!1007 = !DILocation(line: 576, column: 9, scope: !1008, inlinedAt: !1000)
!1008 = distinct !DILexicalBlock(scope: !448, file: !3, line: 576, column: 8)
!1009 = !DILocation(line: 576, column: 8, scope: !448, inlinedAt: !1000)
!1010 = !DILocation(line: 577, column: 9, scope: !1011, inlinedAt: !1000)
!1011 = distinct !DILexicalBlock(scope: !1012, file: !3, line: 577, column: 9)
!1012 = distinct !DILexicalBlock(scope: !1008, file: !3, line: 576, column: 16)
!1013 = !DILocation(line: 578, column: 9, scope: !1012, inlinedAt: !1000)
!1014 = !DILocation(line: 594, column: 35, scope: !448, inlinedAt: !1000)
!1015 = !DILocation(line: 595, column: 9, scope: !1016, inlinedAt: !1000)
!1016 = distinct !DILexicalBlock(scope: !448, file: !3, line: 595, column: 8)
!1017 = !DILocation(line: 595, column: 8, scope: !448, inlinedAt: !1000)
!1018 = !DILocation(line: 596, column: 9, scope: !1019, inlinedAt: !1000)
!1019 = distinct !DILexicalBlock(scope: !1020, file: !3, line: 596, column: 9)
!1020 = distinct !DILexicalBlock(scope: !1016, file: !3, line: 595, column: 21)
!1021 = !DILocation(line: 597, column: 9, scope: !1020, inlinedAt: !1000)
!1022 = !DILocation(line: 600, column: 23, scope: !448, inlinedAt: !1000)
!1023 = !{!1024, !499, i64 0}
!1024 = !{!"map_elem", !499, i64 0}
!1025 = !DILocation(line: 604, column: 5, scope: !448, inlinedAt: !1000)
!1026 = !DILocation(line: 605, column: 1, scope: !448, inlinedAt: !1000)
!1027 = !DILocation(line: 621, column: 25, scope: !231)
!1028 = !DILocation(line: 0, scope: !514, inlinedAt: !1029)
!1029 = distinct !DILocation(line: 622, column: 9, scope: !1030)
!1030 = distinct !DILexicalBlock(scope: !231, file: !3, line: 622, column: 8)
!1031 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !1029)
!1032 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !1029)
!1033 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !1029)
!1034 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !1029)
!1035 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !1029)
!1036 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !1029)
!1037 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !1029)
!1038 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !1029)
!1039 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !1029)
!1040 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !1029)
!1041 = !DILocation(line: 622, column: 8, scope: !231)
!1042 = !DILocation(line: 623, column: 9, scope: !1043)
!1043 = distinct !DILexicalBlock(scope: !1044, file: !3, line: 623, column: 9)
!1044 = distinct !DILexicalBlock(scope: !1030, file: !3, line: 622, column: 54)
!1045 = !DILocation(line: 624, column: 5, scope: !1044)
!1046 = !DILocation(line: 626, column: 5, scope: !231)
!1047 = !DILocation(line: 0, scope: !241)
!1048 = !DILocation(line: 632, column: 15, scope: !241)
!1049 = !DILocation(line: 0, scope: !477, inlinedAt: !1050)
!1050 = distinct !DILocation(line: 635, column: 9, scope: !1051)
!1051 = distinct !DILexicalBlock(scope: !241, file: !3, line: 635, column: 8)
!1052 = !DILocation(line: 215, column: 21, scope: !477, inlinedAt: !1050)
!1053 = !DILocation(line: 216, column: 9, scope: !492, inlinedAt: !1050)
!1054 = !DILocation(line: 216, column: 8, scope: !477, inlinedAt: !1050)
!1055 = !DILocation(line: 223, column: 1, scope: !477, inlinedAt: !1050)
!1056 = !DILocation(line: 635, column: 8, scope: !241)
!1057 = !DILocation(line: 219, column: 5, scope: !477, inlinedAt: !1050)
!1058 = !DILocation(line: 219, column: 24, scope: !477, inlinedAt: !1050)
!1059 = !DILocation(line: 219, column: 33, scope: !477, inlinedAt: !1050)
!1060 = !DILocation(line: 219, column: 11, scope: !477, inlinedAt: !1050)
!1061 = !DILocation(line: 220, column: 5, scope: !477, inlinedAt: !1050)
!1062 = !DILocation(line: 222, column: 12, scope: !477, inlinedAt: !1050)
!1063 = !DILocation(line: 635, column: 9, scope: !1051)
!1064 = !DILocation(line: 636, column: 9, scope: !1065)
!1065 = distinct !DILexicalBlock(scope: !1066, file: !3, line: 636, column: 9)
!1066 = distinct !DILexicalBlock(scope: !1051, file: !3, line: 635, column: 30)
!1067 = !DILocation(line: 637, column: 5, scope: !1066)
!1068 = !DILocation(line: 639, column: 26, scope: !241)
!1069 = !DILocation(line: 643, column: 9, scope: !241)
!1070 = !DILocation(line: 643, column: 25, scope: !241)
!1071 = !DILocation(line: 643, column: 40, scope: !241)
!1072 = !DILocation(line: 644, column: 33, scope: !241)
!1073 = !DILocation(line: 645, column: 13, scope: !250)
!1074 = !DILocation(line: 645, column: 12, scope: !241)
!1075 = !DILocation(line: 646, column: 13, scope: !249)
!1076 = !DILocation(line: 0, scope: !249)
!1077 = !DILocation(line: 646, column: 19, scope: !249)
!1078 = !DILocation(line: 647, column: 13, scope: !249)
!1079 = !DILocation(line: 649, column: 20, scope: !249)
!1080 = !DILocation(line: 650, column: 17, scope: !1081)
!1081 = distinct !DILexicalBlock(scope: !249, file: !3, line: 650, column: 16)
!1082 = !DILocation(line: 650, column: 16, scope: !249)
!1083 = !DILocation(line: 651, column: 17, scope: !1084)
!1084 = distinct !DILexicalBlock(scope: !1085, file: !3, line: 651, column: 17)
!1085 = distinct !DILexicalBlock(scope: !1081, file: !3, line: 650, column: 23)
!1086 = !DILocation(line: 654, column: 9, scope: !250)
!1087 = !DILocation(line: 655, column: 21, scope: !241)
!1088 = !DILocation(line: 658, column: 25, scope: !241)
!1089 = !DILocation(line: 0, scope: !514, inlinedAt: !1090)
!1090 = distinct !DILocation(line: 659, column: 9, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !241, file: !3, line: 659, column: 8)
!1092 = !DILocation(line: 226, column: 21, scope: !514, inlinedAt: !1090)
!1093 = !DILocation(line: 227, column: 9, scope: !527, inlinedAt: !1090)
!1094 = !DILocation(line: 227, column: 8, scope: !514, inlinedAt: !1090)
!1095 = !DILocation(line: 230, column: 5, scope: !514, inlinedAt: !1090)
!1096 = !DILocation(line: 230, column: 24, scope: !514, inlinedAt: !1090)
!1097 = !DILocation(line: 230, column: 48, scope: !514, inlinedAt: !1090)
!1098 = !DILocation(line: 230, column: 33, scope: !514, inlinedAt: !1090)
!1099 = !DILocation(line: 230, column: 11, scope: !514, inlinedAt: !1090)
!1100 = !DILocation(line: 231, column: 5, scope: !514, inlinedAt: !1090)
!1101 = !DILocation(line: 234, column: 1, scope: !514, inlinedAt: !1090)
!1102 = !DILocation(line: 659, column: 8, scope: !241)
!1103 = !DILocation(line: 660, column: 9, scope: !1104)
!1104 = distinct !DILexicalBlock(scope: !1105, file: !3, line: 660, column: 9)
!1105 = distinct !DILexicalBlock(scope: !1091, file: !3, line: 659, column: 54)
!1106 = !DILocation(line: 661, column: 5, scope: !1105)
!1107 = !DILocation(line: 664, column: 1, scope: !241)
