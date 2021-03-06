VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Private Sub Worksheet_Change(ByVal Target As Range)
    Application.EnableEvents = False
    Application.ScreenUpdating = False
    Main.Unprotect
    On Error GoTo ExitSub
    
    If Not Intersect(Target, vars.fault_ref) Is Nothing Then
        Run "check_fault_ref"
    ElseIf Not Intersect(Target, vars.magnitude) Is Nothing Then
        Run "get_area_from_mag"
    ElseIf Not Intersect(Target, vars.rake) Is Nothing Then
        Run "get_mechanism"
    ElseIf Not Intersect(Target, vars.finite_fault_model) Is Nothing Then
        Run "finite_fault_model"
    ElseIf Not Intersect(Target, vars.segment_count) Is Nothing Then
        Run "manage_segments"
        Run "make_plot"
    ElseIf Target.Count = 1 And Not (Intersect(Target, Main.Range("C:C")) Is Nothing) And Target.Row > 25 Then
        Run "manage_vertices", Target
        Run "make_plot"
    ElseIf Not Intersect(Target, Main.Range("D27", "W57")) Is Nothing Then
        Run "copy_vertices"
    End If

ExitSub:
    If Selection.Count > 1 Then
        Target.Select
    End If
    
    Application.EnableEvents = True
    Application.ScreenUpdating = True
    
    
    Run "protect_workbook"
End Sub

Private Sub Worksheet_SelectionChange(ByVal Target As Range)
    Application.EnableEvents = False
    Application.ScreenUpdating = False
    Main.Unprotect
    On Error GoTo ExitSub
    
    If Not Intersect(Target, vars.eq_date) Is Nothing Then
        DateForm.Show
    ElseIf Not Intersect(Target, vars.eq_time) Is Nothing Then
        TimeForm.Show
    End If
    
ExitSub:
    Application.EnableEvents = True
    Application.ScreenUpdating = True
    Target.Select
    
    Run "protect_workbook"
End Sub



