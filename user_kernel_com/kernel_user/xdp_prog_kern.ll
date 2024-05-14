; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [6 x i32]*, i32*, i32*, [64 x i32]* }
%struct.anon.0 = type { [17 x i32]*, i32*, i32*, [64 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@xdp_stats_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@xsks_map = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !47
@xdp_sock_prog.____fmt = internal constant [11 x i8] c"TEST %d %d\00", align 1, !dbg !15
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !42
@llvm.used = appending global [4 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_sock_prog to i8*), i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* bitcast (%struct.anon.0* @xsks_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_sock_prog(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_sock" !dbg !17 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !32, metadata !DIExpression()), !dbg !105
  %3 = bitcast i32* %2 to i8*, !dbg !106
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3) #3, !dbg !106
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 4, !dbg !107
  %5 = load i32, i32* %4, align 4, !dbg !107, !tbaa !108
  call void @llvm.dbg.value(metadata i32 %5, metadata !33, metadata !DIExpression()), !dbg !105
  store i32 %5, i32* %2, align 4, !dbg !113, !tbaa !114
  call void @llvm.dbg.value(metadata i32* %2, metadata !33, metadata !DIExpression(DW_OP_deref)), !dbg !105
  %6 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !115
  call void @llvm.dbg.value(metadata i8* %6, metadata !34, metadata !DIExpression()), !dbg !105
  %7 = call i32 inttoptr (i64 8 to i32 ()*)() #3, !dbg !116
  call void @llvm.dbg.value(metadata i32 %7, metadata !36, metadata !DIExpression()), !dbg !105
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @xsks_map to i8*), i8* nonnull %3) #3, !dbg !117
  %9 = icmp eq i8* %8, null, !dbg !117
  br i1 %9, label %17, label %10, !dbg !119

10:                                               ; preds = %1
  %11 = load i32, i32* %2, align 4, !dbg !120, !tbaa !114
  call void @llvm.dbg.value(metadata i32 %11, metadata !33, metadata !DIExpression()), !dbg !105
  %12 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @xdp_sock_prog.____fmt, i64 0, i64 0), i32 11, i32 %7, i32 %11) #3, !dbg !120
  %13 = load i32, i32* %2, align 4, !dbg !123, !tbaa !114
  call void @llvm.dbg.value(metadata i32 %13, metadata !33, metadata !DIExpression()), !dbg !105
  %14 = sext i32 %13 to i64, !dbg !123
  %15 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.0* @xsks_map to i8*), i64 %14, i64 0) #3, !dbg !124
  %16 = trunc i64 %15 to i32, !dbg !124
  br label %17, !dbg !125

17:                                               ; preds = %1, %10
  %18 = phi i32 [ %16, %10 ], [ 2, %1 ], !dbg !105
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3) #3, !dbg !126
  ret i32 %18, !dbg !126
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!101, !102, !103}
!llvm.ident = !{!104}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 27, type: !91, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 11.0.0-2~ubuntu20.04.1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !14, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/user_kernel_com/kernel_user")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 3150, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!15, !42, !47, !0, !63, !72, !77, !84}
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "____fmt", scope: !17, file: !3, line: 47, type: !37, isLocal: true, isDefinition: true)
!17 = distinct !DISubprogram(name: "xdp_sock_prog", scope: !3, file: !3, line: 30, type: !18, scopeLine: 31, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !31)
!18 = !DISubroutineType(types: !19)
!19 = !{!20, !21}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3161, size: 160, elements: !23)
!23 = !{!24, !27, !28, !29, !30}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !22, file: !6, line: 3162, baseType: !25, size: 32)
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !26, line: 27, baseType: !7)
!26 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!27 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !22, file: !6, line: 3163, baseType: !25, size: 32, offset: 32)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !22, file: !6, line: 3164, baseType: !25, size: 32, offset: 64)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !22, file: !6, line: 3166, baseType: !25, size: 32, offset: 96)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !22, file: !6, line: 3167, baseType: !25, size: 32, offset: 128)
!31 = !{!32, !33, !34, !36}
!32 = !DILocalVariable(name: "ctx", arg: 1, scope: !17, file: !3, line: 30, type: !21)
!33 = !DILocalVariable(name: "index", scope: !17, file: !3, line: 32, type: !20)
!34 = !DILocalVariable(name: "pkt_count", scope: !17, file: !3, line: 33, type: !35)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!36 = !DILocalVariable(name: "cpu", scope: !17, file: !3, line: 45, type: !20)
!37 = !DICompositeType(tag: DW_TAG_array_type, baseType: !38, size: 88, elements: !40)
!38 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!39 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!40 = !{!41}
!41 = !DISubrange(count: 11)
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 54, type: !44, isLocal: false, isDefinition: true)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 32, elements: !45)
!45 = !{!46}
!46 = !DISubrange(count: 4)
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(name: "xsks_map", scope: !2, file: !3, line: 20, type: !49, isLocal: false, isDefinition: true)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 15, size: 256, elements: !50)
!50 = !{!51, !56, !57, !58}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !49, file: !3, line: 16, baseType: !52, size: 64)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 544, elements: !54)
!54 = !{!55}
!55 = !DISubrange(count: 17)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !49, file: !3, line: 17, baseType: !35, size: 64, offset: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !49, file: !3, line: 18, baseType: !35, size: 64, offset: 128)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !49, file: !3, line: 19, baseType: !59, size: 64, offset: 192)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 2048, elements: !61)
!61 = !{!62}
!62 = !DISubrange(count: 64)
!63 = !DIGlobalVariableExpression(var: !64, expr: !DIExpression())
!64 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !65, line: 56, type: !66, isLocal: true, isDefinition: true)
!65 = !DIFile(filename: "../lib/install/include/bpf/bpf_helper_defs.h", directory: "/home/pvvalenc/benchmark/benchmark_XDP_map/user_kernel_com/kernel_user")
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DISubroutineType(types: !68)
!68 = !{!69, !69, !70}
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !65, line: 206, type: !74, isLocal: true, isDefinition: true)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DISubroutineType(types: !76)
!76 = !{!25}
!77 = !DIGlobalVariableExpression(var: !78, expr: !DIExpression())
!78 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !65, line: 177, type: !79, isLocal: true, isDefinition: true)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !80, size: 64)
!80 = !DISubroutineType(types: !81)
!81 = !{!82, !83, !25, null}
!82 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !65, line: 1323, type: !86, isLocal: true, isDefinition: true)
!86 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !87, size: 64)
!87 = !DISubroutineType(types: !88)
!88 = !{!82, !69, !89, !89}
!89 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !26, line: 31, baseType: !90)
!90 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!91 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 22, size: 256, elements: !92)
!92 = !{!93, !98, !99, !100}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !91, file: !3, line: 23, baseType: !94, size: 64)
!94 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !95, size: 64)
!95 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 192, elements: !96)
!96 = !{!97}
!97 = !DISubrange(count: 6)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !91, file: !3, line: 24, baseType: !35, size: 64, offset: 64)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !91, file: !3, line: 25, baseType: !35, size: 64, offset: 128)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !91, file: !3, line: 26, baseType: !59, size: 64, offset: 192)
!101 = !{i32 7, !"Dwarf Version", i32 4}
!102 = !{i32 2, !"Debug Info Version", i32 3}
!103 = !{i32 1, !"wchar_size", i32 4}
!104 = !{!"Ubuntu clang version 11.0.0-2~ubuntu20.04.1"}
!105 = !DILocation(line: 0, scope: !17)
!106 = !DILocation(line: 32, column: 5, scope: !17)
!107 = !DILocation(line: 32, column: 22, scope: !17)
!108 = !{!109, !110, i64 16}
!109 = !{!"xdp_md", !110, i64 0, !110, i64 4, !110, i64 8, !110, i64 12, !110, i64 16}
!110 = !{!"int", !111, i64 0}
!111 = !{!"omnipotent char", !112, i64 0}
!112 = !{!"Simple C/C++ TBAA"}
!113 = !DILocation(line: 32, column: 9, scope: !17)
!114 = !{!110, !110, i64 0}
!115 = !DILocation(line: 35, column: 17, scope: !17)
!116 = !DILocation(line: 45, column: 15, scope: !17)
!117 = !DILocation(line: 46, column: 9, scope: !118)
!118 = distinct !DILexicalBlock(scope: !17, file: !3, line: 46, column: 9)
!119 = !DILocation(line: 46, column: 9, scope: !17)
!120 = !DILocation(line: 47, column: 9, scope: !121)
!121 = distinct !DILexicalBlock(scope: !122, file: !3, line: 47, column: 9)
!122 = distinct !DILexicalBlock(scope: !118, file: !3, line: 46, column: 49)
!123 = !DILocation(line: 48, column: 44, scope: !122)
!124 = !DILocation(line: 48, column: 16, scope: !122)
!125 = !DILocation(line: 48, column: 9, scope: !122)
!126 = !DILocation(line: 52, column: 1, scope: !17)
