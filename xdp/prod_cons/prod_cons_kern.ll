; ModuleID = 'prod_cons_kern.c'
source_filename = "prod_cons_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.inner_array = type { ptr, ptr, ptr, ptr }
%struct.anon = type { ptr, ptr, ptr, ptr }
%struct.hash_key = type { i32 }

@inner_index = dso_local local_unnamed_addr global [10 x i32] zeroinitializer, align 4, !dbg !0
@inner_array0 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !133
@inner_array1 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !135
@inner_array2 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !137
@inner_array3 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !139
@inner_array4 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !141
@inner_array5 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !143
@inner_array6 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !145
@inner_array7 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !147
@inner_array8 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !149
@inner_array9 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !151
@outer_hash = dso_local global { ptr, ptr, ptr, [10 x ptr] } { ptr null, ptr null, ptr null, [10 x ptr] [ptr @inner_array0, ptr @inner_array1, ptr @inner_array2, ptr @inner_array3, ptr @inner_array4, ptr @inner_array5, ptr @inner_array6, ptr @inner_array7, ptr @inner_array8, ptr @inner_array9] }, section ".maps", align 8, !dbg !21
@testing_prod_cons.____fmt = internal constant [3 x i8] c"%d\00", align 1, !dbg !70
@testing_prod_cons.____fmt.1 = internal constant [32 x i8] c"Couldn't get entry of outer map\00", align 1, !dbg !99
@testing_prod_cons.____fmt.2 = internal constant [31 x i8] c"Couldn't get entry of hash map\00", align 1, !dbg !104
@testing_prod_cons.____fmt.3 = internal constant [32 x i8] c"Couldn't get entry of inner map\00", align 1, !dbg !109
@testing_prod_cons.____fmt.4 = internal constant [25 x i8] c"Queue of CPU %d is empty\00", align 1, !dbg !111
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !116
@index_hash = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !121
@get_array_map.____fmt = internal constant [31 x i8] c"Creating new entry in hash map\00", align 1, !dbg !174
@get_array_map.____fmt.5 = internal constant [24 x i8] c"Found entry in hash map\00", align 1, !dbg !185
@llvm.compiler.used = appending global [14 x ptr] [ptr @_license, ptr @index_hash, ptr @inner_array0, ptr @inner_array1, ptr @inner_array2, ptr @inner_array3, ptr @inner_array4, ptr @inner_array5, ptr @inner_array6, ptr @inner_array7, ptr @inner_array8, ptr @inner_array9, ptr @outer_hash, ptr @testing_prod_cons], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @testing_prod_cons(ptr nocapture readnone %0) #0 section "xdp" !dbg !72 {
  %2 = alloca %struct.hash_key, align 4
  %3 = alloca i64, align 8
  %4 = alloca %struct.hash_key, align 4
  call void @llvm.dbg.value(metadata ptr poison, metadata !85, metadata !DIExpression()), !dbg !200
  %5 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !201
  call void @llvm.dbg.value(metadata i32 %5, metadata !86, metadata !DIExpression()), !dbg !200
  %6 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt, i32 noundef 3, i32 noundef %5) #4, !dbg !202
  %7 = icmp ult i32 %5, 8
  br i1 %7, label %8, label %13, !dbg !204

8:                                                ; preds = %1
  %9 = zext i32 %5 to i64, !dbg !206
  %10 = getelementptr inbounds [10 x i32], ptr @inner_index, i64 0, i64 %9, !dbg !206
  %11 = load i32, ptr %10, align 4, !dbg !206, !tbaa !207
  %12 = add nsw i32 %11, 1, !dbg !211
  store i32 %12, ptr %10, align 4, !dbg !212, !tbaa !207
  br label %13, !dbg !213

13:                                               ; preds = %8, %1
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4) #4, !dbg !214
  call void @llvm.dbg.declare(metadata ptr %4, metadata !87, metadata !DIExpression()), !dbg !215
  store i32 %5, ptr %4, align 4, !dbg !216, !tbaa !217
  call void @llvm.dbg.value(metadata i32 0, metadata !88, metadata !DIExpression()), !dbg !200
  br label %14, !dbg !219

14:                                               ; preds = %13, %52
  %15 = phi i32 [ 0, %13 ], [ %53, %52 ]
  call void @llvm.dbg.value(metadata i32 %15, metadata !88, metadata !DIExpression()), !dbg !200
  %16 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @outer_hash, ptr noundef nonnull %4) #4, !dbg !220
  call void @llvm.dbg.value(metadata ptr %16, metadata !89, metadata !DIExpression()), !dbg !221
  %17 = icmp eq ptr %16, null, !dbg !222
  br i1 %17, label %18, label %20, !dbg !224

18:                                               ; preds = %14
  %19 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.1, i32 noundef 32) #4, !dbg !225
  br label %55, !dbg !228

20:                                               ; preds = %14
  %21 = load i32, ptr %4, align 4, !dbg !229
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2)
  store i32 %21, ptr %2, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !180, metadata !DIExpression()), !dbg !230
  %22 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @index_hash, ptr noundef nonnull %2) #4, !dbg !232
  call void @llvm.dbg.value(metadata ptr %22, metadata !181, metadata !DIExpression()), !dbg !233
  %23 = icmp eq ptr %22, null, !dbg !234
  br i1 %23, label %26, label %24, !dbg !235

24:                                               ; preds = %20
  %25 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @get_array_map.____fmt.5, i32 noundef 24) #4, !dbg !236
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !238
  call void @llvm.dbg.value(metadata ptr %22, metadata !91, metadata !DIExpression()), !dbg !221
  br label %33, !dbg !239

26:                                               ; preds = %20
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %3) #4, !dbg !240
  call void @llvm.dbg.value(metadata i64 0, metadata !182, metadata !DIExpression()), !dbg !241
  store i64 0, ptr %3, align 8, !dbg !242, !tbaa !243
  call void @llvm.dbg.value(metadata ptr %3, metadata !182, metadata !DIExpression(DW_OP_deref)), !dbg !241
  %27 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @index_hash, ptr noundef nonnull %2, ptr noundef nonnull %3, i64 noundef 1) #4, !dbg !245
  %28 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @get_array_map.____fmt, i32 noundef 31) #4, !dbg !246
  %29 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @index_hash, ptr noundef nonnull %2) #4, !dbg !248
  call void @llvm.dbg.value(metadata ptr %29, metadata !181, metadata !DIExpression()), !dbg !233
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %3) #4, !dbg !249
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !238
  call void @llvm.dbg.value(metadata ptr %29, metadata !91, metadata !DIExpression()), !dbg !221
  %30 = icmp eq ptr %29, null, !dbg !250
  br i1 %30, label %31, label %33, !dbg !239

31:                                               ; preds = %26
  %32 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.2, i32 noundef 31) #4, !dbg !252
  br label %55, !dbg !255

33:                                               ; preds = %24, %26
  %34 = phi ptr [ %22, %24 ], [ %29, %26 ]
  %35 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull %16, ptr noundef nonnull %34) #4, !dbg !256
  call void @llvm.dbg.value(metadata ptr %35, metadata !93, metadata !DIExpression()), !dbg !221
  %36 = icmp eq ptr %35, null, !dbg !257
  br i1 %36, label %37, label %39, !dbg !259

37:                                               ; preds = %33
  %38 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.3, i32 noundef 32) #4, !dbg !260
  br label %55, !dbg !263

39:                                               ; preds = %33
  %40 = atomicrmw or ptr %35, i64 0 seq_cst, align 8, !dbg !264
  %41 = icmp eq i64 %40, 0, !dbg !264
  br i1 %41, label %42, label %44, !dbg !266

42:                                               ; preds = %39
  %43 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.4, i32 noundef 25, i32 noundef %5) #4, !dbg !267
  br label %55, !dbg !270

44:                                               ; preds = %39
  %45 = atomicrmw sub ptr %35, i64 1 seq_cst, align 8, !dbg !271
  %46 = load i64, ptr %34, align 8, !dbg !272, !tbaa !243
  %47 = icmp ult i64 %46, 14, !dbg !274
  br i1 %47, label %48, label %50, !dbg !275

48:                                               ; preds = %44
  %49 = atomicrmw add ptr %34, i64 1 seq_cst, align 8, !dbg !276
  br label %52, !dbg !276

50:                                               ; preds = %44
  %51 = atomicrmw xor ptr %34, i64 %46 seq_cst, align 8, !dbg !277
  br label %52

52:                                               ; preds = %48, %50
  %53 = add nuw nsw i32 %15, 1, !dbg !278
  call void @llvm.dbg.value(metadata i32 %53, metadata !88, metadata !DIExpression()), !dbg !200
  %54 = icmp eq i32 %53, 5, !dbg !279
  br i1 %54, label %55, label %14, !dbg !219

55:                                               ; preds = %52, %37, %42, %31, %18
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4) #4, !dbg !280
  ret i32 1, !dbg !280
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!195, !196, !197, !198}
!llvm.ident = !{!199}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "inner_index", scope: !2, file: !3, line: 18, type: !38, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "prod_cons_kern.c", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/prod_cons", checksumkind: CSK_MD5, checksum: "a6ca22be041c66e520a57653bee69c1f")
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
!20 = !{!0, !21, !70, !99, !104, !109, !111, !116, !121, !133, !135, !137, !139, !141, !143, !145, !147, !149, !151, !153, !159, !166, !174, !185, !190}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "outer_hash", scope: !2, file: !3, line: 57, type: !23, isLocal: false, isDefinition: true)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_hash", file: !3, line: 52, size: 192, elements: !24)
!24 = !{!25, !31, !36, !41}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !23, file: !3, line: 53, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 416, elements: !29)
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !{!30}
!30 = !DISubrange(count: 13)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !23, file: !3, line: 54, baseType: !32, size: 64, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash_key", file: !3, line: 25, size: 32, elements: !34)
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "cpu", scope: !33, file: !3, line: 26, baseType: !28, size: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !23, file: !3, line: 55, baseType: !37, size: 64, offset: 128)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 320, elements: !39)
!39 = !{!40}
!40 = !DISubrange(count: 10)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !23, file: !3, line: 56, baseType: !42, offset: 192)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, elements: !68)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "inner_array", file: !3, line: 36, size: 256, elements: !45)
!45 = !{!46, !51, !55, !63}
!46 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !44, file: !3, line: 37, baseType: !47, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 64, elements: !49)
!49 = !{!50}
!50 = !DISubrange(count: 2)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !44, file: !3, line: 38, baseType: !52, size: 64, offset: 64)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !54, line: 27, baseType: !7)
!54 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!55 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !44, file: !3, line: 39, baseType: !56, size: 64, offset: 128)
!56 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !57, size: 64)
!57 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "map_elem", file: !3, line: 20, size: 128, elements: !58)
!58 = !{!59, !62}
!59 = !DIDerivedType(tag: DW_TAG_member, name: "occupied", scope: !57, file: !3, line: 21, baseType: !60, size: 64)
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !54, line: 31, baseType: !61)
!61 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !57, file: !3, line: 22, baseType: !60, size: 64, offset: 64)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !44, file: !3, line: 40, baseType: !64, size: 64, offset: 192)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 480, elements: !66)
!66 = !{!67}
!67 = !DISubrange(count: 15)
!68 = !{!69}
!69 = !DISubrange(count: -1)
!70 = !DIGlobalVariableExpression(var: !71, expr: !DIExpression())
!71 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 101, type: !94, isLocal: true, isDefinition: true)
!72 = distinct !DISubprogram(name: "testing_prod_cons", scope: !3, file: !3, line: 89, type: !73, scopeLine: 90, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !84)
!73 = !DISubroutineType(types: !74)
!74 = !{!28, !75}
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 5447, size: 192, elements: !77)
!77 = !{!78, !79, !80, !81, !82, !83}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !76, file: !6, line: 5448, baseType: !53, size: 32)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !76, file: !6, line: 5449, baseType: !53, size: 32, offset: 32)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !76, file: !6, line: 5450, baseType: !53, size: 32, offset: 64)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !76, file: !6, line: 5452, baseType: !53, size: 32, offset: 96)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !76, file: !6, line: 5453, baseType: !53, size: 32, offset: 128)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !76, file: !6, line: 5455, baseType: !53, size: 32, offset: 160)
!84 = !{!85, !86, !87, !88, !89, !91, !93}
!85 = !DILocalVariable(name: "ctx", arg: 1, scope: !72, file: !3, line: 89, type: !75)
!86 = !DILocalVariable(name: "cpu", scope: !72, file: !3, line: 100, type: !53)
!87 = !DILocalVariable(name: "key", scope: !72, file: !3, line: 113, type: !33)
!88 = !DILocalVariable(name: "i", scope: !72, file: !3, line: 116, type: !28)
!89 = !DILocalVariable(name: "inner", scope: !90, file: !3, line: 119, type: !43)
!90 = distinct !DILexicalBlock(scope: !72, file: !3, line: 117, column: 46)
!91 = !DILocalVariable(name: "index", scope: !90, file: !3, line: 127, type: !92)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!93 = !DILocalVariable(name: "inner_elem", scope: !90, file: !3, line: 134, type: !56)
!94 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 24, elements: !97)
!95 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !96)
!96 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!97 = !{!98}
!98 = !DISubrange(count: 3)
!99 = !DIGlobalVariableExpression(var: !100, expr: !DIExpression())
!100 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 122, type: !101, isLocal: true, isDefinition: true)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 256, elements: !102)
!102 = !{!103}
!103 = !DISubrange(count: 32)
!104 = !DIGlobalVariableExpression(var: !105, expr: !DIExpression())
!105 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 129, type: !106, isLocal: true, isDefinition: true)
!106 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 248, elements: !107)
!107 = !{!108}
!108 = !DISubrange(count: 31)
!109 = !DIGlobalVariableExpression(var: !110, expr: !DIExpression())
!110 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 136, type: !101, isLocal: true, isDefinition: true)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 141, type: !113, isLocal: true, isDefinition: true)
!113 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 200, elements: !114)
!114 = !{!115}
!115 = !DISubrange(count: 25)
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 168, type: !118, isLocal: false, isDefinition: true)
!118 = !DICompositeType(tag: DW_TAG_array_type, baseType: !96, size: 32, elements: !119)
!119 = !{!120}
!120 = !DISubrange(count: 4)
!121 = !DIGlobalVariableExpression(var: !122, expr: !DIExpression())
!122 = distinct !DIGlobalVariable(name: "index_hash", scope: !2, file: !3, line: 34, type: !123, isLocal: false, isDefinition: true)
!123 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 29, size: 256, elements: !124)
!124 = !{!125, !130, !131, !132}
!125 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !123, file: !3, line: 30, baseType: !126, size: 64)
!126 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !127, size: 64)
!127 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 32, elements: !128)
!128 = !{!129}
!129 = !DISubrange(count: 1)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !123, file: !3, line: 31, baseType: !32, size: 64, offset: 64)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !123, file: !3, line: 32, baseType: !92, size: 64, offset: 128)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !123, file: !3, line: 33, baseType: !37, size: 64, offset: 192)
!133 = !DIGlobalVariableExpression(var: !134, expr: !DIExpression())
!134 = distinct !DIGlobalVariable(name: "inner_array0", scope: !2, file: !3, line: 41, type: !44, isLocal: false, isDefinition: true)
!135 = !DIGlobalVariableExpression(var: !136, expr: !DIExpression())
!136 = distinct !DIGlobalVariable(name: "inner_array1", scope: !2, file: !3, line: 42, type: !44, isLocal: false, isDefinition: true)
!137 = !DIGlobalVariableExpression(var: !138, expr: !DIExpression())
!138 = distinct !DIGlobalVariable(name: "inner_array2", scope: !2, file: !3, line: 43, type: !44, isLocal: false, isDefinition: true)
!139 = !DIGlobalVariableExpression(var: !140, expr: !DIExpression())
!140 = distinct !DIGlobalVariable(name: "inner_array3", scope: !2, file: !3, line: 44, type: !44, isLocal: false, isDefinition: true)
!141 = !DIGlobalVariableExpression(var: !142, expr: !DIExpression())
!142 = distinct !DIGlobalVariable(name: "inner_array4", scope: !2, file: !3, line: 45, type: !44, isLocal: false, isDefinition: true)
!143 = !DIGlobalVariableExpression(var: !144, expr: !DIExpression())
!144 = distinct !DIGlobalVariable(name: "inner_array5", scope: !2, file: !3, line: 46, type: !44, isLocal: false, isDefinition: true)
!145 = !DIGlobalVariableExpression(var: !146, expr: !DIExpression())
!146 = distinct !DIGlobalVariable(name: "inner_array6", scope: !2, file: !3, line: 47, type: !44, isLocal: false, isDefinition: true)
!147 = !DIGlobalVariableExpression(var: !148, expr: !DIExpression())
!148 = distinct !DIGlobalVariable(name: "inner_array7", scope: !2, file: !3, line: 48, type: !44, isLocal: false, isDefinition: true)
!149 = !DIGlobalVariableExpression(var: !150, expr: !DIExpression())
!150 = distinct !DIGlobalVariable(name: "inner_array8", scope: !2, file: !3, line: 49, type: !44, isLocal: false, isDefinition: true)
!151 = !DIGlobalVariableExpression(var: !152, expr: !DIExpression())
!152 = distinct !DIGlobalVariable(name: "inner_array9", scope: !2, file: !3, line: 50, type: !44, isLocal: false, isDefinition: true)
!153 = !DIGlobalVariableExpression(var: !154, expr: !DIExpression())
!154 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !155, line: 206, type: !156, isLocal: true, isDefinition: true)
!155 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/prod_cons", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !157, size: 64)
!157 = !DISubroutineType(types: !158)
!158 = !{!53}
!159 = !DIGlobalVariableExpression(var: !160, expr: !DIExpression())
!160 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !155, line: 177, type: !161, isLocal: true, isDefinition: true)
!161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !162, size: 64)
!162 = !DISubroutineType(types: !163)
!163 = !{!164, !165, !53, null}
!164 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!165 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !95, size: 64)
!166 = !DIGlobalVariableExpression(var: !167, expr: !DIExpression())
!167 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !155, line: 56, type: !168, isLocal: true, isDefinition: true)
!168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !169, size: 64)
!169 = !DISubroutineType(types: !170)
!170 = !{!171, !171, !172}
!171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!172 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !173, size: 64)
!173 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!174 = !DIGlobalVariableExpression(var: !175, expr: !DIExpression())
!175 = distinct !DIGlobalVariable(name: "____fmt", scope: !176, file: !3, line: 78, type: !106, isLocal: true, isDefinition: true)
!176 = distinct !DISubprogram(name: "get_array_map", scope: !3, file: !3, line: 73, type: !177, scopeLine: 73, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !179)
!177 = !DISubroutineType(types: !178)
!178 = !{!92, !33}
!179 = !{!180, !181, !182}
!180 = !DILocalVariable(name: "key", arg: 1, scope: !176, file: !3, line: 73, type: !33)
!181 = !DILocalVariable(name: "index", scope: !176, file: !3, line: 74, type: !92)
!182 = !DILocalVariable(name: "new_value", scope: !183, file: !3, line: 76, type: !60)
!183 = distinct !DILexicalBlock(scope: !184, file: !3, line: 75, column: 16)
!184 = distinct !DILexicalBlock(scope: !176, file: !3, line: 75, column: 8)
!185 = !DIGlobalVariableExpression(var: !186, expr: !DIExpression())
!186 = distinct !DIGlobalVariable(name: "____fmt", scope: !176, file: !3, line: 84, type: !187, isLocal: true, isDefinition: true)
!187 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 192, elements: !188)
!188 = !{!189}
!189 = !DISubrange(count: 24)
!190 = !DIGlobalVariableExpression(var: !191, expr: !DIExpression())
!191 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !155, line: 78, type: !192, isLocal: true, isDefinition: true)
!192 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !193, size: 64)
!193 = !DISubroutineType(types: !194)
!194 = !{!164, !171, !172, !172, !60}
!195 = !{i32 7, !"Dwarf Version", i32 5}
!196 = !{i32 2, !"Debug Info Version", i32 3}
!197 = !{i32 1, !"wchar_size", i32 4}
!198 = !{i32 7, !"frame-pointer", i32 2}
!199 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!200 = !DILocation(line: 0, scope: !72)
!201 = !DILocation(line: 100, column: 17, scope: !72)
!202 = !DILocation(line: 101, column: 5, scope: !203)
!203 = distinct !DILexicalBlock(scope: !72, file: !3, line: 101, column: 5)
!204 = !DILocation(line: 110, column: 17, scope: !205)
!205 = distinct !DILexicalBlock(scope: !72, file: !3, line: 110, column: 8)
!206 = !DILocation(line: 111, column: 29, scope: !205)
!207 = !{!208, !208, i64 0}
!208 = !{!"int", !209, i64 0}
!209 = !{!"omnipotent char", !210, i64 0}
!210 = !{!"Simple C/C++ TBAA"}
!211 = !DILocation(line: 111, column: 46, scope: !205)
!212 = !DILocation(line: 111, column: 27, scope: !205)
!213 = !DILocation(line: 111, column: 9, scope: !205)
!214 = !DILocation(line: 113, column: 5, scope: !72)
!215 = !DILocation(line: 113, column: 21, scope: !72)
!216 = !DILocation(line: 114, column: 13, scope: !72)
!217 = !{!218, !208, i64 0}
!218 = !{!"hash_key", !208, i64 0}
!219 = !DILocation(line: 117, column: 5, scope: !72)
!220 = !DILocation(line: 120, column: 17, scope: !90)
!221 = !DILocation(line: 0, scope: !90)
!222 = !DILocation(line: 121, column: 13, scope: !223)
!223 = distinct !DILexicalBlock(scope: !90, file: !3, line: 121, column: 12)
!224 = !DILocation(line: 121, column: 12, scope: !90)
!225 = !DILocation(line: 122, column: 13, scope: !226)
!226 = distinct !DILexicalBlock(scope: !227, file: !3, line: 122, column: 13)
!227 = distinct !DILexicalBlock(scope: !223, file: !3, line: 121, column: 20)
!228 = !DILocation(line: 123, column: 13, scope: !227)
!229 = !DILocation(line: 127, column: 24, scope: !90)
!230 = !DILocation(line: 73, column: 46, scope: !176, inlinedAt: !231)
!231 = distinct !DILocation(line: 127, column: 24, scope: !90)
!232 = !DILocation(line: 74, column: 20, scope: !176, inlinedAt: !231)
!233 = !DILocation(line: 0, scope: !176, inlinedAt: !231)
!234 = !DILocation(line: 75, column: 9, scope: !184, inlinedAt: !231)
!235 = !DILocation(line: 75, column: 8, scope: !176, inlinedAt: !231)
!236 = !DILocation(line: 84, column: 5, scope: !237, inlinedAt: !231)
!237 = distinct !DILexicalBlock(scope: !176, file: !3, line: 84, column: 5)
!238 = !DILocation(line: 86, column: 1, scope: !176, inlinedAt: !231)
!239 = !DILocation(line: 128, column: 12, scope: !90)
!240 = !DILocation(line: 76, column: 9, scope: !183, inlinedAt: !231)
!241 = !DILocation(line: 0, scope: !183, inlinedAt: !231)
!242 = !DILocation(line: 76, column: 15, scope: !183, inlinedAt: !231)
!243 = !{!244, !244, i64 0}
!244 = !{!"long long", !209, i64 0}
!245 = !DILocation(line: 77, column: 9, scope: !183, inlinedAt: !231)
!246 = !DILocation(line: 78, column: 9, scope: !247, inlinedAt: !231)
!247 = distinct !DILexicalBlock(scope: !183, file: !3, line: 78, column: 9)
!248 = !DILocation(line: 79, column: 17, scope: !183, inlinedAt: !231)
!249 = !DILocation(line: 83, column: 5, scope: !184, inlinedAt: !231)
!250 = !DILocation(line: 128, column: 13, scope: !251)
!251 = distinct !DILexicalBlock(scope: !90, file: !3, line: 128, column: 12)
!252 = !DILocation(line: 129, column: 13, scope: !253)
!253 = distinct !DILexicalBlock(scope: !254, file: !3, line: 129, column: 13)
!254 = distinct !DILexicalBlock(scope: !251, file: !3, line: 128, column: 20)
!255 = !DILocation(line: 130, column: 13, scope: !254)
!256 = !DILocation(line: 134, column: 39, scope: !90)
!257 = !DILocation(line: 135, column: 13, scope: !258)
!258 = distinct !DILexicalBlock(scope: !90, file: !3, line: 135, column: 12)
!259 = !DILocation(line: 135, column: 12, scope: !90)
!260 = !DILocation(line: 136, column: 13, scope: !261)
!261 = distinct !DILexicalBlock(scope: !262, file: !3, line: 136, column: 13)
!262 = distinct !DILexicalBlock(scope: !258, file: !3, line: 135, column: 25)
!263 = !DILocation(line: 137, column: 13, scope: !262)
!264 = !DILocation(line: 140, column: 13, scope: !265)
!265 = distinct !DILexicalBlock(scope: !90, file: !3, line: 140, column: 12)
!266 = !DILocation(line: 140, column: 12, scope: !90)
!267 = !DILocation(line: 141, column: 13, scope: !268)
!268 = distinct !DILexicalBlock(scope: !269, file: !3, line: 141, column: 13)
!269 = distinct !DILexicalBlock(scope: !265, file: !3, line: 140, column: 85)
!270 = !DILocation(line: 142, column: 13, scope: !269)
!271 = !DILocation(line: 146, column: 9, scope: !90)
!272 = !DILocation(line: 156, column: 13, scope: !273)
!273 = distinct !DILexicalBlock(scope: !90, file: !3, line: 156, column: 12)
!274 = !DILocation(line: 156, column: 21, scope: !273)
!275 = !DILocation(line: 156, column: 12, scope: !90)
!276 = !DILocation(line: 157, column: 13, scope: !273)
!277 = !DILocation(line: 159, column: 13, scope: !273)
!278 = !DILocation(line: 162, column: 10, scope: !90)
!279 = !DILocation(line: 117, column: 13, scope: !72)
!280 = !DILocation(line: 166, column: 1, scope: !72)
