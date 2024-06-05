; ModuleID = 'prod_cons_kern.c'
source_filename = "prod_cons_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.inner_array = type { ptr, ptr, ptr, ptr }
%struct.anon = type { ptr, ptr, ptr, ptr }
%struct.hash_key = type { i32 }

@inner_array0 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !0
@inner_array1 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !133
@inner_array2 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !135
@inner_array3 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !137
@inner_array4 = dso_local global %struct.inner_array zeroinitializer, section ".maps", align 8, !dbg !139
@outer_hash = dso_local global { ptr, ptr, ptr, [5 x ptr] } { ptr null, ptr null, ptr null, [5 x ptr] [ptr @inner_array0, ptr @inner_array1, ptr @inner_array2, ptr @inner_array3, ptr @inner_array4] }, section ".maps", align 8, !dbg !21
@testing_prod_cons.____fmt = internal constant [3 x i8] c"%d\00", align 1, !dbg !70
@testing_prod_cons.____fmt.1 = internal constant [32 x i8] c"Couldn't get entry of outer map\00", align 1, !dbg !99
@testing_prod_cons.____fmt.2 = internal constant [31 x i8] c"Couldn't get entry of hash map\00", align 1, !dbg !104
@testing_prod_cons.____fmt.3 = internal constant [32 x i8] c"Couldn't get entry of inner map\00", align 1, !dbg !109
@testing_prod_cons.____fmt.4 = internal constant [25 x i8] c"Queue of CPU %d is empty\00", align 1, !dbg !111
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !116
@index_hash = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !121
@get_array_map.____fmt = internal constant [31 x i8] c"Creating new entry in hash map\00", align 1, !dbg !162
@get_array_map.____fmt.5 = internal constant [24 x i8] c"Found entry in hash map\00", align 1, !dbg !173
@llvm.compiler.used = appending global [9 x ptr] [ptr @_license, ptr @index_hash, ptr @inner_array0, ptr @inner_array1, ptr @inner_array2, ptr @inner_array3, ptr @inner_array4, ptr @outer_hash, ptr @testing_prod_cons], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @testing_prod_cons(ptr nocapture readnone %0) #0 section "xdp" !dbg !72 {
  %2 = alloca %struct.hash_key, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct.hash_key, align 4
  call void @llvm.dbg.value(metadata ptr poison, metadata !85, metadata !DIExpression()), !dbg !188
  %5 = tail call i32 inttoptr (i64 8 to ptr)() #4, !dbg !189
  call void @llvm.dbg.value(metadata i32 %5, metadata !86, metadata !DIExpression()), !dbg !188
  %6 = tail call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt, i32 noundef 3, i32 noundef %5) #4, !dbg !190
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4) #4, !dbg !192
  call void @llvm.dbg.declare(metadata ptr %4, metadata !87, metadata !DIExpression()), !dbg !193
  store i32 %5, ptr %4, align 4, !dbg !194, !tbaa !195
  call void @llvm.dbg.value(metadata i32 0, metadata !88, metadata !DIExpression()), !dbg !188
  br label %7, !dbg !200

7:                                                ; preds = %1, %45
  %8 = phi i32 [ 0, %1 ], [ %46, %45 ]
  call void @llvm.dbg.value(metadata i32 %8, metadata !88, metadata !DIExpression()), !dbg !188
  %9 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @outer_hash, ptr noundef nonnull %4) #4, !dbg !201
  call void @llvm.dbg.value(metadata ptr %9, metadata !89, metadata !DIExpression()), !dbg !202
  %10 = icmp eq ptr %9, null, !dbg !203
  br i1 %10, label %11, label %13, !dbg !205

11:                                               ; preds = %7
  %12 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.1, i32 noundef 32) #4, !dbg !206
  br label %48, !dbg !209

13:                                               ; preds = %7
  %14 = load i32, ptr %4, align 4, !dbg !210
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %2)
  store i32 %14, ptr %2, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !168, metadata !DIExpression()), !dbg !211
  %15 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @index_hash, ptr noundef nonnull %2) #4, !dbg !213
  call void @llvm.dbg.value(metadata ptr %15, metadata !169, metadata !DIExpression()), !dbg !214
  %16 = icmp eq ptr %15, null, !dbg !215
  br i1 %16, label %19, label %17, !dbg !216

17:                                               ; preds = %13
  %18 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @get_array_map.____fmt.5, i32 noundef 24) #4, !dbg !217
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !219
  call void @llvm.dbg.value(metadata ptr %15, metadata !91, metadata !DIExpression()), !dbg !202
  br label %26, !dbg !220

19:                                               ; preds = %13
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3) #4, !dbg !221
  call void @llvm.dbg.value(metadata i32 0, metadata !170, metadata !DIExpression()), !dbg !222
  store i32 0, ptr %3, align 4, !dbg !223, !tbaa !224
  call void @llvm.dbg.value(metadata ptr %3, metadata !170, metadata !DIExpression(DW_OP_deref)), !dbg !222
  %20 = call i64 inttoptr (i64 2 to ptr)(ptr noundef nonnull @index_hash, ptr noundef nonnull %2, ptr noundef nonnull %3, i64 noundef 1) #4, !dbg !225
  %21 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @get_array_map.____fmt, i32 noundef 31) #4, !dbg !226
  %22 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull @index_hash, ptr noundef nonnull %2) #4, !dbg !228
  call void @llvm.dbg.value(metadata ptr %22, metadata !169, metadata !DIExpression()), !dbg !214
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3) #4, !dbg !229
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %2), !dbg !219
  call void @llvm.dbg.value(metadata ptr %22, metadata !91, metadata !DIExpression()), !dbg !202
  %23 = icmp eq ptr %22, null, !dbg !230
  br i1 %23, label %24, label %26, !dbg !220

24:                                               ; preds = %19
  %25 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.2, i32 noundef 31) #4, !dbg !232
  br label %48, !dbg !235

26:                                               ; preds = %17, %19
  %27 = phi ptr [ %15, %17 ], [ %22, %19 ]
  %28 = call ptr inttoptr (i64 1 to ptr)(ptr noundef nonnull %9, ptr noundef nonnull %27) #4, !dbg !236
  call void @llvm.dbg.value(metadata ptr %28, metadata !93, metadata !DIExpression()), !dbg !202
  %29 = icmp eq ptr %28, null, !dbg !237
  br i1 %29, label %30, label %32, !dbg !239

30:                                               ; preds = %26
  %31 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.3, i32 noundef 32) #4, !dbg !240
  br label %48, !dbg !243

32:                                               ; preds = %26
  %33 = load i64, ptr %28, align 8, !dbg !244, !tbaa !246
  %34 = icmp eq i64 %33, 0, !dbg !249
  br i1 %34, label %35, label %37, !dbg !250

35:                                               ; preds = %32
  %36 = call i64 (ptr, i32, ...) inttoptr (i64 6 to ptr)(ptr noundef nonnull @testing_prod_cons.____fmt.4, i32 noundef 25, i32 noundef %5) #4, !dbg !251
  br label %48, !dbg !254

37:                                               ; preds = %32
  %38 = atomicrmw sub ptr %28, i64 1 seq_cst, align 8, !dbg !255
  %39 = load i64, ptr %27, align 8, !dbg !256, !tbaa !258
  %40 = icmp ult i64 %39, 14, !dbg !259
  br i1 %40, label %41, label %43, !dbg !260

41:                                               ; preds = %37
  %42 = atomicrmw add ptr %27, i64 1 seq_cst, align 8, !dbg !261
  br label %45, !dbg !261

43:                                               ; preds = %37
  %44 = atomicrmw xor ptr %27, i64 %39 seq_cst, align 8, !dbg !262
  br label %45

45:                                               ; preds = %41, %43
  %46 = add nuw nsw i32 %8, 1, !dbg !263
  call void @llvm.dbg.value(metadata i32 %46, metadata !88, metadata !DIExpression()), !dbg !188
  %47 = icmp eq i32 %46, 5, !dbg !264
  br i1 %47, label %48, label %7, !dbg !200

48:                                               ; preds = %45, %30, %35, %24, %11
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4) #4, !dbg !265
  ret i32 1, !dbg !265
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
!llvm.module.flags = !{!183, !184, !185, !186}
!llvm.ident = !{!187}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "inner_array0", scope: !2, file: !3, line: 41, type: !44, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "prod_cons_kern.c", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/prod_cons", checksumkind: CSK_MD5, checksum: "98e65b4ad6aab2609a715c0e5ff58eb3")
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
!20 = !{!21, !70, !99, !104, !109, !111, !116, !121, !0, !133, !135, !137, !139, !141, !147, !154, !162, !173, !178}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "outer_hash", scope: !2, file: !3, line: 52, type: !23, isLocal: false, isDefinition: true)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "outer_hash", file: !3, line: 47, size: 192, elements: !24)
!24 = !{!25, !31, !36, !41}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !23, file: !3, line: 48, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 416, elements: !29)
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !{!30}
!30 = !DISubrange(count: 13)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !23, file: !3, line: 49, baseType: !32, size: 64, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hash_key", file: !3, line: 25, size: 32, elements: !34)
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "cpu", scope: !33, file: !3, line: 26, baseType: !28, size: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !23, file: !3, line: 50, baseType: !37, size: 64, offset: 128)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 160, elements: !39)
!39 = !{!40}
!40 = !DISubrange(count: 5)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "values", scope: !23, file: !3, line: 51, baseType: !42, offset: 192)
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
!71 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 91, type: !94, isLocal: true, isDefinition: true)
!72 = distinct !DISubprogram(name: "testing_prod_cons", scope: !3, file: !3, line: 79, type: !73, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !84)
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
!85 = !DILocalVariable(name: "ctx", arg: 1, scope: !72, file: !3, line: 79, type: !75)
!86 = !DILocalVariable(name: "cpu", scope: !72, file: !3, line: 90, type: !53)
!87 = !DILocalVariable(name: "key", scope: !72, file: !3, line: 101, type: !33)
!88 = !DILocalVariable(name: "i", scope: !72, file: !3, line: 104, type: !28)
!89 = !DILocalVariable(name: "inner", scope: !90, file: !3, line: 107, type: !43)
!90 = distinct !DILexicalBlock(scope: !72, file: !3, line: 105, column: 46)
!91 = !DILocalVariable(name: "index", scope: !90, file: !3, line: 115, type: !92)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!93 = !DILocalVariable(name: "inner_elem", scope: !90, file: !3, line: 122, type: !56)
!94 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 24, elements: !97)
!95 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !96)
!96 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!97 = !{!98}
!98 = !DISubrange(count: 3)
!99 = !DIGlobalVariableExpression(var: !100, expr: !DIExpression())
!100 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 110, type: !101, isLocal: true, isDefinition: true)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 256, elements: !102)
!102 = !{!103}
!103 = !DISubrange(count: 32)
!104 = !DIGlobalVariableExpression(var: !105, expr: !DIExpression())
!105 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 117, type: !106, isLocal: true, isDefinition: true)
!106 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 248, elements: !107)
!107 = !{!108}
!108 = !DISubrange(count: 31)
!109 = !DIGlobalVariableExpression(var: !110, expr: !DIExpression())
!110 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 124, type: !101, isLocal: true, isDefinition: true)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "____fmt", scope: !72, file: !3, line: 129, type: !113, isLocal: true, isDefinition: true)
!113 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 200, elements: !114)
!114 = !{!115}
!115 = !DISubrange(count: 25)
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 156, type: !118, isLocal: false, isDefinition: true)
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
!134 = distinct !DIGlobalVariable(name: "inner_array1", scope: !2, file: !3, line: 42, type: !44, isLocal: false, isDefinition: true)
!135 = !DIGlobalVariableExpression(var: !136, expr: !DIExpression())
!136 = distinct !DIGlobalVariable(name: "inner_array2", scope: !2, file: !3, line: 43, type: !44, isLocal: false, isDefinition: true)
!137 = !DIGlobalVariableExpression(var: !138, expr: !DIExpression())
!138 = distinct !DIGlobalVariable(name: "inner_array3", scope: !2, file: !3, line: 44, type: !44, isLocal: false, isDefinition: true)
!139 = !DIGlobalVariableExpression(var: !140, expr: !DIExpression())
!140 = distinct !DIGlobalVariable(name: "inner_array4", scope: !2, file: !3, line: 45, type: !44, isLocal: false, isDefinition: true)
!141 = !DIGlobalVariableExpression(var: !142, expr: !DIExpression())
!142 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !143, line: 206, type: !144, isLocal: true, isDefinition: true)
!143 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/xdp/prod_cons", checksumkind: CSK_MD5, checksum: "7422ca06c9dc86eba2f268a57d8acf2f")
!144 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !145, size: 64)
!145 = !DISubroutineType(types: !146)
!146 = !{!53}
!147 = !DIGlobalVariableExpression(var: !148, expr: !DIExpression())
!148 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !143, line: 177, type: !149, isLocal: true, isDefinition: true)
!149 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !150, size: 64)
!150 = !DISubroutineType(types: !151)
!151 = !{!152, !153, !53, null}
!152 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!153 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !95, size: 64)
!154 = !DIGlobalVariableExpression(var: !155, expr: !DIExpression())
!155 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !143, line: 56, type: !156, isLocal: true, isDefinition: true)
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !157, size: 64)
!157 = !DISubroutineType(types: !158)
!158 = !{!159, !159, !160}
!159 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !161, size: 64)
!161 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!162 = !DIGlobalVariableExpression(var: !163, expr: !DIExpression())
!163 = distinct !DIGlobalVariable(name: "____fmt", scope: !164, file: !3, line: 68, type: !106, isLocal: true, isDefinition: true)
!164 = distinct !DISubprogram(name: "get_array_map", scope: !3, file: !3, line: 63, type: !165, scopeLine: 63, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !167)
!165 = !DISubroutineType(types: !166)
!166 = !{!92, !33}
!167 = !{!168, !169, !170}
!168 = !DILocalVariable(name: "key", arg: 1, scope: !164, file: !3, line: 63, type: !33)
!169 = !DILocalVariable(name: "index", scope: !164, file: !3, line: 64, type: !92)
!170 = !DILocalVariable(name: "new_value", scope: !171, file: !3, line: 66, type: !53)
!171 = distinct !DILexicalBlock(scope: !172, file: !3, line: 65, column: 16)
!172 = distinct !DILexicalBlock(scope: !164, file: !3, line: 65, column: 8)
!173 = !DIGlobalVariableExpression(var: !174, expr: !DIExpression())
!174 = distinct !DIGlobalVariable(name: "____fmt", scope: !164, file: !3, line: 74, type: !175, isLocal: true, isDefinition: true)
!175 = !DICompositeType(tag: DW_TAG_array_type, baseType: !95, size: 192, elements: !176)
!176 = !{!177}
!177 = !DISubrange(count: 24)
!178 = !DIGlobalVariableExpression(var: !179, expr: !DIExpression())
!179 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !143, line: 78, type: !180, isLocal: true, isDefinition: true)
!180 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !181, size: 64)
!181 = !DISubroutineType(types: !182)
!182 = !{!152, !159, !160, !160, !60}
!183 = !{i32 7, !"Dwarf Version", i32 5}
!184 = !{i32 2, !"Debug Info Version", i32 3}
!185 = !{i32 1, !"wchar_size", i32 4}
!186 = !{i32 7, !"frame-pointer", i32 2}
!187 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!188 = !DILocation(line: 0, scope: !72)
!189 = !DILocation(line: 90, column: 17, scope: !72)
!190 = !DILocation(line: 91, column: 5, scope: !191)
!191 = distinct !DILexicalBlock(scope: !72, file: !3, line: 91, column: 5)
!192 = !DILocation(line: 101, column: 5, scope: !72)
!193 = !DILocation(line: 101, column: 21, scope: !72)
!194 = !DILocation(line: 102, column: 13, scope: !72)
!195 = !{!196, !197, i64 0}
!196 = !{!"hash_key", !197, i64 0}
!197 = !{!"int", !198, i64 0}
!198 = !{!"omnipotent char", !199, i64 0}
!199 = !{!"Simple C/C++ TBAA"}
!200 = !DILocation(line: 105, column: 5, scope: !72)
!201 = !DILocation(line: 108, column: 17, scope: !90)
!202 = !DILocation(line: 0, scope: !90)
!203 = !DILocation(line: 109, column: 13, scope: !204)
!204 = distinct !DILexicalBlock(scope: !90, file: !3, line: 109, column: 12)
!205 = !DILocation(line: 109, column: 12, scope: !90)
!206 = !DILocation(line: 110, column: 13, scope: !207)
!207 = distinct !DILexicalBlock(scope: !208, file: !3, line: 110, column: 13)
!208 = distinct !DILexicalBlock(scope: !204, file: !3, line: 109, column: 20)
!209 = !DILocation(line: 111, column: 13, scope: !208)
!210 = !DILocation(line: 115, column: 24, scope: !90)
!211 = !DILocation(line: 63, column: 46, scope: !164, inlinedAt: !212)
!212 = distinct !DILocation(line: 115, column: 24, scope: !90)
!213 = !DILocation(line: 64, column: 20, scope: !164, inlinedAt: !212)
!214 = !DILocation(line: 0, scope: !164, inlinedAt: !212)
!215 = !DILocation(line: 65, column: 9, scope: !172, inlinedAt: !212)
!216 = !DILocation(line: 65, column: 8, scope: !164, inlinedAt: !212)
!217 = !DILocation(line: 74, column: 5, scope: !218, inlinedAt: !212)
!218 = distinct !DILexicalBlock(scope: !164, file: !3, line: 74, column: 5)
!219 = !DILocation(line: 76, column: 1, scope: !164, inlinedAt: !212)
!220 = !DILocation(line: 116, column: 12, scope: !90)
!221 = !DILocation(line: 66, column: 9, scope: !171, inlinedAt: !212)
!222 = !DILocation(line: 0, scope: !171, inlinedAt: !212)
!223 = !DILocation(line: 66, column: 15, scope: !171, inlinedAt: !212)
!224 = !{!197, !197, i64 0}
!225 = !DILocation(line: 67, column: 9, scope: !171, inlinedAt: !212)
!226 = !DILocation(line: 68, column: 9, scope: !227, inlinedAt: !212)
!227 = distinct !DILexicalBlock(scope: !171, file: !3, line: 68, column: 9)
!228 = !DILocation(line: 69, column: 17, scope: !171, inlinedAt: !212)
!229 = !DILocation(line: 73, column: 5, scope: !172, inlinedAt: !212)
!230 = !DILocation(line: 116, column: 13, scope: !231)
!231 = distinct !DILexicalBlock(scope: !90, file: !3, line: 116, column: 12)
!232 = !DILocation(line: 117, column: 13, scope: !233)
!233 = distinct !DILexicalBlock(scope: !234, file: !3, line: 117, column: 13)
!234 = distinct !DILexicalBlock(scope: !231, file: !3, line: 116, column: 20)
!235 = !DILocation(line: 118, column: 13, scope: !234)
!236 = !DILocation(line: 122, column: 39, scope: !90)
!237 = !DILocation(line: 123, column: 13, scope: !238)
!238 = distinct !DILexicalBlock(scope: !90, file: !3, line: 123, column: 12)
!239 = !DILocation(line: 123, column: 12, scope: !90)
!240 = !DILocation(line: 124, column: 13, scope: !241)
!241 = distinct !DILexicalBlock(scope: !242, file: !3, line: 124, column: 13)
!242 = distinct !DILexicalBlock(scope: !238, file: !3, line: 123, column: 25)
!243 = !DILocation(line: 125, column: 13, scope: !242)
!244 = !DILocation(line: 128, column: 25, scope: !245)
!245 = distinct !DILexicalBlock(scope: !90, file: !3, line: 128, column: 12)
!246 = !{!247, !248, i64 0}
!247 = !{!"map_elem", !248, i64 0, !248, i64 8}
!248 = !{!"long long", !198, i64 0}
!249 = !DILocation(line: 128, column: 13, scope: !245)
!250 = !DILocation(line: 128, column: 12, scope: !90)
!251 = !DILocation(line: 129, column: 13, scope: !252)
!252 = distinct !DILexicalBlock(scope: !253, file: !3, line: 129, column: 13)
!253 = distinct !DILexicalBlock(scope: !245, file: !3, line: 128, column: 35)
!254 = !DILocation(line: 130, column: 13, scope: !253)
!255 = !DILocation(line: 134, column: 9, scope: !90)
!256 = !DILocation(line: 144, column: 13, scope: !257)
!257 = distinct !DILexicalBlock(scope: !90, file: !3, line: 144, column: 12)
!258 = !{!248, !248, i64 0}
!259 = !DILocation(line: 144, column: 21, scope: !257)
!260 = !DILocation(line: 144, column: 12, scope: !90)
!261 = !DILocation(line: 145, column: 13, scope: !257)
!262 = !DILocation(line: 147, column: 13, scope: !257)
!263 = !DILocation(line: 150, column: 10, scope: !90)
!264 = !DILocation(line: 105, column: 13, scope: !72)
!265 = !DILocation(line: 154, column: 1, scope: !72)
