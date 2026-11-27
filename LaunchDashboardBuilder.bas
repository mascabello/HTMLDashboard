Attribute VB_Name = "LaunchDashboardBuilder"
'==========================================================================
' PRODUCT LAUNCH DASHBOARD - workbook builder
'
' How to run (desktop Excel for Windows, Microsoft 365):
'   1. Open a blank workbook, press Alt+F11, then File > Import File...
'      and choose this .bas file.
'   2. Back in Excel press Alt+F8, select BuildLaunchDashboard, click Run.
'   3. Paste the two links when asked (product master, PLM report), or
'      leave them empty and paste them later on the Sources tab.
'   4. Sign in to SharePoint if Excel asks (organisational account).
'   5. A NEW workbook is built. Save it as .xlsx - it contains no macros.
'
' Changing a link later: edit the yellow cells on the Sources tab and click
' Data > Refresh All. If a link was empty when you built the workbook, run
' FinishLaunchDashboard once after pasting it, so the default filters are set.
'==========================================================================
Option Explicit

Private gStep As String
Private NAVY As Long
Private ORANGE As Long
Private LIGHT As Long
Private MIDGREY As Long
Private DARKTXT As Long
Private LINEC As Long
Private PALEBLUE As Long
Private INPUTC As Long

Private Const LIST_ROWS As Long = 30
Private Const ACTIVE_LIST_LINK As String = "https://deutschebank.sharepoint.com/sites/ProductStrategyandBusinessDevelopment/Lists/Product%20Events%202027/AllItems.aspx"

'==========================================================================
' PUBLIC MACROS
'==========================================================================
Public Sub BuildLaunchDashboard()
    Dim wb As Workbook
    Dim wsData As Worksheet
    Dim wsSrc As Worksheet
    Dim pmLink As String
    Dim plmLink As String
    Dim msg As String

    InitColours
    On Error GoTo Fail

    gStep = "asking for the links"
    pmLink = Trim$(InputBox("PRODUCT MASTER" & vbCrLf & vbCrLf & _
        "Paste the link of the SharePoint folder where the weekly extracts are saved " & _
        "(open the folder in your browser and copy the whole address bar)." & vbCrLf & vbCrLf & _
        "A link to one Excel file also works (in Excel: File > Info > Copy path)." & vbCrLf & _
        "Leave empty to paste it later on the Sources tab.", "Link 1 of 2 - Product master"))
    plmLink = Trim$(InputBox("PLM REPORT" & vbCrLf & vbCrLf & _
        "Paste the link of the SharePoint folder where the PLM reports are saved " & _
        "(open the folder in your browser and copy the whole address bar)." & vbCrLf & vbCrLf & _
        "A link to one Excel file also works (in Excel: File > Info > Copy path)." & vbCrLf & _
        "Leave empty to paste it later on the Sources tab.", "Link 2 of 2 - PLM report"))

    gStep = "creating the new workbook"
    Application.ScreenUpdating = False
    Set wb = Workbooks.Add(xlWBATWorksheet)
    Set wsData = wb.Worksheets(1)
    wsData.Name = "Data"
    Set wsSrc = wb.Worksheets.Add(After:=wsData)
    wsSrc.Name = "Sources"

    ' Ignore Power Query privacy levels for this workbook (all sources are internal)
    ' and use Arial everywhere (cells, slicers and charts follow the theme font)
    On Error Resume Next
    wb.Queries.FastCombine = True
    wb.Theme.ThemeFontScheme.MinorFont.Item(1).Name = "Arial"
    wb.Theme.ThemeFontScheme.MajorFont.Item(1).Name = "Arial"
    wb.Styles("Normal").Font.Name = "Arial"
    Err.Clear
    On Error GoTo Fail

    gStep = "writing the Sources tab"
    BuildSources wb, wsSrc, pmLink, plmLink

    gStep = "adding the Power Query queries"
    AddQuery wb, "qPM", MQ_PM()
    AddQuery wb, "qPLM", MQ_PLM()
    AddQuery wb, "qActive", MQ_Active()
    AddQuery wb, "qEvents", MQ_Events()
    AddQuery wb, "qLive", MQ_Live()
    AddQuery wb, "qAsAt", MQ_AsAt()
    AddQuery wb, "qChecks", MQ_Checks()

    gStep = "creating the data tables"
    LoadQuery wsData, "qEvents", "tblEvents", wsData.Range("A1"), True
    LoadQuery wsSrc, "qAsAt", "tblAsAt", wsSrc.Range("H5"), False
    LoadQuery wsSrc, "qLive", "tblLive", wsSrc.Range("M5"), False
    LoadQuery wsSrc, "qChecks", "tblChecks", wsSrc.Range("H14"), False

    If Not LoadAndBuild(wb, msg) Then
        Application.ScreenUpdating = True
        wsSrc.Activate
        MsgBox msg, vbExclamation, "Launch dashboard"
        Exit Sub
    End If

    If pmLink = "" Or plmLink = "" Then
        MsgBox "Dashboard built with the data that could be reached." & vbCrLf & vbCrLf & _
            "Paste the missing link(s) in the yellow cells on the Sources tab, then run " & _
            "FinishLaunchDashboard (Alt+F8) once." & vbCrLf & vbCrLf & _
            "Then save the workbook as an .xlsx file.", vbInformation, "Launch dashboard"
    Else
        MsgBox DoneText(), vbInformation, "Launch dashboard"
    End If
    Exit Sub

Fail:
    Application.ScreenUpdating = True
    Application.DisplayAlerts = True
    Application.StatusBar = False
    MsgBox "The builder stopped while " & gStep & "." & vbCrLf & vbCrLf & _
        "Error " & Err.Number & ": " & Err.Description & vbCrLf & vbCrLf & _
        "Send a screenshot of this message to Claude.", vbCritical, "Launch dashboard"
End Sub

' Run this on the dashboard workbook after changing links or mappings,
' or if the first build stopped at the data step.
Public Sub FinishLaunchDashboard()
    Dim wb As Workbook
    Dim msg As String

    InitColours
    On Error GoTo Fail

    gStep = "checking the active workbook"
    Set wb = ActiveWorkbook
    If Not SheetExists(wb, "Data") Or Not SheetExists(wb, "Sources") Then
        MsgBox "Click into the dashboard workbook (the one with the Data and Sources tabs) " & _
            "and run this macro again.", vbExclamation, "Launch dashboard"
        Exit Sub
    End If

    If Not LoadAndBuild(wb, msg) Then
        Application.ScreenUpdating = True
        wb.Worksheets("Sources").Activate
        MsgBox msg, vbExclamation, "Launch dashboard"
        Exit Sub
    End If
    MsgBox DoneText(), vbInformation, "Launch dashboard"
    Exit Sub

Fail:
    Application.ScreenUpdating = True
    Application.DisplayAlerts = True
    Application.StatusBar = False
    MsgBox "The builder stopped while " & gStep & "." & vbCrLf & vbCrLf & _
        "Error " & Err.Number & ": " & Err.Description & vbCrLf & vbCrLf & _
        "Send a screenshot of this message to Claude.", vbCritical, "Launch dashboard"
End Sub

'==========================================================================
' LOAD + BUILD
'==========================================================================
Private Function LoadAndBuild(wb As Workbook, ByRef msg As String) As Boolean
    Dim ok As Boolean
    Dim lo As ListObject

    gStep = "loading the data from SharePoint"
    Application.ScreenUpdating = True
    Application.StatusBar = "Loading data from SharePoint - sign in if Excel asks..."
    ok = RefreshTable(wb.Worksheets("Data").ListObjects("tblEvents"), msg)
    If ok Then ok = RefreshTable(wb.Worksheets("Sources").ListObjects("tblAsAt"), msg)
    If ok Then ok = RefreshTable(wb.Worksheets("Sources").ListObjects("tblLive"), msg)
    If ok Then ok = RefreshTable(wb.Worksheets("Sources").ListObjects("tblChecks"), msg)
    Application.StatusBar = False

    If Not ok Then
        msg = "The data could not be loaded:" & vbCrLf & vbCrLf & msg & vbCrLf & vbCrLf & _
            "Check the links in the yellow cells on the Sources tab, then run " & _
            "FinishLaunchDashboard (Alt+F8)."
        LoadAndBuild = False
        Exit Function
    End If

    Set lo = wb.Worksheets("Data").ListObjects("tblEvents")
    If lo.ListRows.Count = 0 Then
        msg = "The links worked but no events were found." & vbCrLf & vbCrLf & _
            "Look at the Data checks table on the Sources tab, fix the links or the " & _
            "mappings, then run FinishLaunchDashboard (Alt+F8)."
        LoadAndBuild = False
        Exit Function
    End If

    BuildVisuals wb
    LoadAndBuild = True
End Function

Private Function DoneText() As String
    DoneText = "Dashboard ready." & vbCrLf & vbCrLf & _
        "1. Save this workbook as an .xlsx file (File > Save As)." & vbCrLf & _
        "2. Each week: save the new extracts in the SharePoint folders, open the " & _
        "dashboard and click Data > Refresh All." & vbCrLf & _
        "3. The first time, look at the Data checks table on the Sources tab."
End Function

Private Sub InitColours()
    NAVY = RGB(10, 31, 92)
    ORANGE = RGB(227, 95, 37)
    LIGHT = RGB(242, 244, 248)
    MIDGREY = RGB(110, 117, 130)
    DARKTXT = RGB(38, 44, 56)
    LINEC = RGB(208, 213, 224)
    PALEBLUE = RGB(214, 222, 238)
    INPUTC = RGB(255, 242, 204)
End Sub

Private Function SheetExists(wb As Workbook, nm As String) As Boolean
    Dim ws As Worksheet
    On Error Resume Next
    Set ws = wb.Worksheets(nm)
    Err.Clear
    On Error GoTo 0
    SheetExists = Not ws Is Nothing
End Function

Private Function FQ(ByVal s As String) As String
    FQ = Replace(s, "`", Chr(34))
End Function

Private Sub Ln(ByRef s As String, ByVal t As String)
    s = s & t & vbLf
End Sub

'==========================================================================
' SOURCES TAB (links, settings, value mappings)
'==========================================================================
Private Sub BuildSources(wb As Workbook, ws As Worksheet, pmLink As String, plmLink As String)
    Dim r As Long

    ws.Cells.Font.Size = 10
    ws.Columns("A").ColumnWidth = 2
    ws.Columns("B").ColumnWidth = 40
    ws.Columns("C").ColumnWidth = 70
    ws.Columns("D").ColumnWidth = 16
    ws.Columns("E").ColumnWidth = 10
    ws.Columns("F:G").ColumnWidth = 3
    ws.Columns("H").ColumnWidth = 16
    ws.Columns("I").ColumnWidth = 48
    ws.Columns("J").ColumnWidth = 34
    ws.Columns("K:L").ColumnWidth = 3
    ws.Columns("M").ColumnWidth = 10
    ws.Columns("N").ColumnWidth = 14
    ws.Columns("O").ColumnWidth = 8
    ws.Tab.Color = MIDGREY

    With ws.Range("B2")
        .Value = "Data sources and settings"
        .Font.Size = 16
        .Font.Bold = True
        .Font.Color = NAVY
    End With
    With ws.Range("B3")
        .Value = "Paste the links in the yellow cells, then click Data > Refresh All."
        .Font.Color = MIDGREY
    End With

    SectionTitle ws.Range("B5"), "PRODUCT MASTER  (completed launches and live products)"
    SetRow wb, ws, 6, "Folder link (or link to one Excel file)", pmLink, "cfg_PM_Link"
    SetRow wb, ws, 7, "If folder: file name contains", "AdvancedSearchReport", "cfg_PM_FileContains"
    SetRow wb, ws, 8, "Sheet name", "Results", "cfg_PM_Sheet"
    SetRow wb, ws, 9, "Count launches from year", "=YEAR(TODAY())-2", "cfg_HistoryFromYear"

    SectionTitle ws.Range("B11"), "PLM REPORT  (passive pipeline and repositionings)"
    SetRow wb, ws, 12, "Folder link (or link to one Excel file)", plmLink, "cfg_PLM_Link"
    SetRow wb, ws, 13, "If folder: file name contains", "Pipeline", "cfg_PLM_FileContains"
    SetRow wb, ws, 14, "Sheet name", "Events reports", "cfg_PLM_Sheet"
    SetRow wb, ws, 15, "Pipeline Relevance must start with", "Yes", "cfg_PLM_Relevance"

    SectionTitle ws.Range("B17"), "ACTIVE PIPELINE  (SharePoint list)"
    SetRow wb, ws, 18, "SharePoint list link (several: separate with ;)", ACTIVE_LIST_LINK, "cfg_Active_Links"
    SetRow wb, ws, 19, "Category must contain", "Shortlist", "cfg_Active_Category"

    SectionTitle ws.Range("B21"), "HOW TO GET THE LINKS"
    NoteRow ws, 22, "Folder: open it in SharePoint in your browser and copy the whole address bar (Teams: Files tab > Open in SharePoint)."
    NoteRow ws, 23, "One Excel file: open it in desktop Excel, then File > Info > Copy path."
    NoteRow ws, 24, "SharePoint list: open the list in your browser and copy the whole address bar."
    NoteRow ws, 25, "Avoid Share > Copy link for 'specific people': those links hide the folder path."
    NoteRow ws, 26, "Example of a folder link: https://deutschebank.sharepoint.com/sites/YourSite/Shared Documents/Dashboard/Product master"

    SectionTitle ws.Range("B28"), "VALUE MAPPINGS  (Include = No switches a value off; add rows for new values)"
    r = 29
    ws.Range("B29:E29").Value = Array("Field", "Source value", "Maps to", "Include")
    MapRow ws, r, "PLM event", "Launch", "Launch", "Yes"
    MapRow ws, r, "PLM event", "Change - Repositioning", "Repositioning", "Yes"
    MapRow ws, r, "PLM event", "Change - Other (Investment Strategy / Policy)", "Other change", "No"
    MapRow ws, r, "PLM event", "Merger", "Merger", "Yes"
    MapRow ws, r, "PLM event", "Termination", "Termination", "Yes"
    MapRow ws, r, "PLM event", "Liquidation", "Termination", "Yes"
    MapRow ws, r, "PLM status", "Ongoing", "Ongoing", "Yes"
    MapRow ws, r, "PLM status", "Completed", "Completed", "Yes"
    MapRow ws, r, "PLM status", "On Hold", "On hold", "No"
    MapRow ws, r, "PLM status", "Cancelled", "Cancelled", "No"
    MapRow ws, r, "Active event", "Launch", "Launch", "Yes"
    MapRow ws, r, "Active event", "Repositioning", "Repositioning", "Yes"
    MapRow ws, r, "Active event", "Merger", "Merger", "Yes"
    MapRow ws, r, "Active event", "Termination", "Termination", "Yes"
    MapRow ws, r, "Region", "EMEA", "EMEA", "Yes"
    MapRow ws, r, "Region", "AMERICAS", "Americas", "Yes"
    MapRow ws, r, "Region", "US", "Americas", "Yes"
    MapRow ws, r, "Region", "APAC", "APAC", "Yes"
    MapRow ws, r, "PM status", "Active", "Live", "Yes"
    ws.ListObjects.Add(xlSrcRange, ws.Range("B29:E" & r), , xlYes).Name = "tblMap"
    ws.ListObjects("tblMap").TableStyle = "TableStyleLight9"

    SectionTitle ws.Range("H4"), "AS AT  (filled by Refresh All)"
    SectionTitle ws.Range("M4"), "LIVE PRODUCTS"
    SectionTitle ws.Range("H13"), "DATA CHECKS  (rows left out and why)"
End Sub

Private Sub SectionTitle(rng As Range, t As String)
    rng.Value = t
    rng.Font.Bold = True
    rng.Font.Size = 10
    rng.Font.Color = NAVY
End Sub

Private Sub NoteRow(ws As Worksheet, r As Long, t As String)
    ws.Cells(r, 2).Value = t
    ws.Cells(r, 2).Font.Size = 9
    ws.Cells(r, 2).Font.Color = MIDGREY
End Sub

Private Sub SetRow(wb As Workbook, ws As Worksheet, r As Long, lbl As String, v As String, nm As String)
    ws.Cells(r, 2).Value = lbl
    If Left$(v, 1) = "=" Then
        ws.Cells(r, 3).Formula = v
    Else
        ws.Cells(r, 3).NumberFormat = "@"
        ws.Cells(r, 3).Value = v
    End If
    ws.Cells(r, 3).Interior.Color = INPUTC
    ws.Cells(r, 3).HorizontalAlignment = xlLeft
    With ws.Cells(r, 3).Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Color = LINEC
    End With
    wb.Names.Add Name:=nm, RefersTo:="='" & ws.Name & "'!" & ws.Cells(r, 3).Address
End Sub

Private Sub MapRow(ws As Worksheet, ByRef r As Long, f As String, sv As String, mt As String, inc As String)
    r = r + 1
    ws.Cells(r, 2).Value = f
    ws.Cells(r, 3).Value = sv
    ws.Cells(r, 4).Value = mt
    ws.Cells(r, 5).Value = inc
End Sub

'==========================================================================
' POWER QUERY PLUMBING
'==========================================================================
Private Sub AddQuery(wb As Workbook, qName As String, mCode As String)
    Dim q As Object
    On Error Resume Next
    Set q = wb.Queries(qName)
    Err.Clear
    On Error GoTo 0
    If q Is Nothing Then
        wb.Queries.Add Name:=qName, Formula:=mCode
    Else
        q.Formula = mCode
    End If
End Sub

Private Sub LoadQuery(ws As Worksheet, qName As String, tblName As String, dest As Range, fitColumns As Boolean)
    Dim lo As ListObject
    Set lo = ws.ListObjects.Add(SourceType:=0, Source:= _
        "OLEDB;Provider=Microsoft.Mashup.OleDb.1;Data Source=$Workbook$;Location=" & qName & ";Extended Properties=""""", _
        Destination:=dest)
    With lo.QueryTable
        .CommandType = xlCmdSql
        .CommandText = Array("SELECT * FROM [" & qName & "]")
        .RowNumbers = False
        .FillAdjacentFormulas = False
        .PreserveFormatting = True
        .RefreshOnFileOpen = False
        .BackgroundQuery = False
        .RefreshStyle = xlInsertDeleteCells
        .SavePassword = False
        .SaveData = True
        .AdjustColumnWidth = fitColumns
        .RefreshPeriod = 0
        .PreserveColumnInfo = True
    End With
    lo.DisplayName = tblName
End Sub

Private Function RefreshTable(lo As ListObject, ByRef msg As String) As Boolean
    On Error Resume Next
    lo.QueryTable.Refresh BackgroundQuery:=False
    If Err.Number <> 0 Then
        msg = lo.DisplayName & ": " & Err.Description
        RefreshTable = False
    Else
        RefreshTable = True
    End If
    Err.Clear
    On Error GoTo 0
End Function

'==========================================================================
' DASHBOARD (pivots, filters, tiles, charts, list)
'==========================================================================
Private Sub BuildVisuals(wb As Workbook)
    Dim wsDash As Worksheet
    Dim wsInit As Worksheet
    Dim wsCalc As Worksheet
    Dim pc As PivotCache
    Dim ptKPI As PivotTable
    Dim ptPie As PivotTable
    Dim ptQ As PivotTable
    Dim ptList As PivotTable
    Dim scBL As SlicerCache
    Dim scPT As SlicerCache
    Dim scET As SlicerCache
    Dim scRG As SlicerCache
    Dim scST As SlicerCache
    Dim scSF As SlicerCache
    Dim scTL As SlicerCache
    Dim hdrRow As Long
    Dim reportYear As Long

    Application.ScreenUpdating = False
    Application.DisplayAlerts = False
    wb.Activate

    gStep = "removing an older version of the dashboard"
    CleanVisuals wb

    gStep = "creating the dashboard tabs"
    Set wsDash = wb.Worksheets.Add(Before:=wb.Worksheets(1))
    wsDash.Name = "Dashboard"
    Set wsInit = wb.Worksheets.Add(After:=wsDash)
    wsInit.Name = "Initiatives"
    Set wsCalc = wb.Worksheets.Add(After:=wb.Worksheets(wb.Worksheets.Count))
    wsCalc.Name = "Calc"
    wsDash.Tab.Color = NAVY
    wsInit.Tab.Color = NAVY

    gStep = "creating the DWS styles"
    MakeStyles wb

    gStep = "creating the helper cells"
    wsCalc.Range("AE1").Value = "Report date"
    wsCalc.Range("AE2").Formula = FQ("=IFERROR(INDEX(tblAsAt[As at],MATCH(`Report date`,tblAsAt[Source],0)),TODAY())")
    wsCalc.Range("AE3").Formula = "=YEAR(AE2)"
    wsCalc.Calculate
    reportYear = Year(Date)
    If IsNumeric(wsCalc.Range("AE3").Value) Then reportYear = CLng(wsCalc.Range("AE3").Value)

    gStep = "creating the pivot tables"
    Set pc = wb.PivotCaches.Create(SourceType:=xlDatabase, SourceData:="tblEvents", Version:=6)
    Set ptKPI = pc.CreatePivotTable(TableDestination:=wsCalc.Range("B4"), TableName:="ptKPI", DefaultVersion:=6)
    With ptKPI
        .ManualUpdate = True
        .PivotFields("Side").Orientation = xlRowField
        .PivotFields("Period").Orientation = xlColumnField
        .AddDataField .PivotFields("Count"), "Events", xlSum
        .ManualUpdate = False
    End With

    Set ptPie = ptKPI.PivotCache.CreatePivotTable(TableDestination:=wsCalc.Range("P4"), TableName:="ptPie", DefaultVersion:=6)
    With ptPie
        .ManualUpdate = True
        .PivotFields("Side").Orientation = xlRowField
        .AddDataField .PivotFields("Count"), "Events", xlSum
        .ColumnGrand = False
        .RowGrand = False
        .ManualUpdate = False
    End With
    ptPie.PivotFields("Side").ShowAllItems = True

    Set ptQ = ptKPI.PivotCache.CreatePivotTable(TableDestination:=wsCalc.Range("T4"), TableName:="ptQuarter", DefaultVersion:=6)
    With ptQ
        .ManualUpdate = True
        .PivotFields("Quarter").Orientation = xlRowField
        .PivotFields("Side").Orientation = xlColumnField
        .AddDataField .PivotFields("Count"), "Events", xlSum
        .ColumnGrand = False
        .RowGrand = False
        .ManualUpdate = False
    End With
    ptQ.PivotFields("Side").ShowAllItems = True
    On Error Resume Next
    ptQ.PivotFields("Quarter").AutoSort xlAscending, "Quarter"
    Err.Clear
    On Error GoTo 0

    Set ptList = ptKPI.PivotCache.CreatePivotTable(TableDestination:=wsInit.Range("B8"), TableName:="ptList", DefaultVersion:=6)
    BuildListPivot ptList
    hdrRow = ptList.TableRange1.Row

    gStep = "laying out the dashboard"
    LayoutDashboard wsDash, hdrRow

    gStep = "creating the filters (slicers)"
    Set scBL = NewCache(wb, ptKPI, "Business line", Array(ptPie, ptQ, ptList))
    Set scPT = NewCache(wb, ptKPI, "Product type", Array(ptPie, ptQ, ptList))
    Set scET = NewCache(wb, ptKPI, "Event type", Array(ptPie, ptQ, ptList))
    Set scRG = NewCache(wb, ptKPI, "Region", Array(ptPie, ptQ, ptList))
    Set scST = NewCache(wb, ptKPI, "Status", Array(ptPie, ptQ))
    Set scSF = NewCache(wb, ptKPI, "SFDR", Array(ptPie, ptQ, ptList))

    gStep = "setting the default view (fund launches)"
    SelectOnly scET, Array("Launch")
    Deselect scPT, Array("Share class")
    On Error Resume Next
    scBL.SortItems = 3          ' descending: Xtrackers, Active
    Err.Clear
    On Error GoTo 0

    gStep = "creating the timeline"
    Set scTL = wb.SlicerCaches.Add2(ptPie, "Event date", , 2)   ' 2 = timeline
    scTL.PivotTables.AddPivotTable ptQ
    scTL.PivotTables.AddPivotTable ptList

    gStep = "placing the filter bar"
    PlaceFilters wsDash, Array(scBL, scPT, scET, scRG, scST, scSF), _
        Array("Business line  (both = PPWS)", "Product type", "Event type", "Region", "Status", "SFDR  (PLM only)"), _
        Array("slcBusinessLine", "slcProductType", "slcEventType", "slcRegion", "slcStatus", "slcSFDR"), scTL
    On Error Resume Next
    scTL.TimelineState.SetFilterDateRange DateSerial(reportYear, 1, 1), DateSerial(reportYear + 1, 12, 31)
    Err.Clear
    On Error GoTo 0

    gStep = "creating the charts"
    MakeCharts wsDash, ptPie, ptQ

    gStep = "formatting the Initiatives and Data tabs"
    FormatInitiatives wsInit
    FormatData wb.Worksheets("Data")

    gStep = "finishing"
    wsCalc.Visible = xlSheetHidden
    wsDash.Activate
    ActiveWindow.DisplayGridlines = False
    ActiveWindow.DisplayHeadings = False
    ActiveWindow.Zoom = 90
    wsDash.Range("A1").Select
    Application.DisplayAlerts = True
    Application.ScreenUpdating = True
End Sub

Private Sub CleanVisuals(wb As Workbook)
    Dim i As Long
    Dim nm As Variant
    On Error Resume Next
    For i = wb.SlicerCaches.Count To 1 Step -1
        wb.SlicerCaches(i).Delete
    Next i
    For Each nm In Array("Dashboard", "Initiatives", "Calc")
        wb.Worksheets(CStr(nm)).Delete
    Next nm
    Err.Clear
    On Error GoTo 0
End Sub

Private Sub BuildListPivot(pt As PivotTable)
    Dim flds As Variant
    Dim i As Long
    flds = Array("Quarter", "Business line", "Product name", "Product type", "Event type", "Region", "SFDR", "Asset class")
    pt.ManualUpdate = True
    For i = LBound(flds) To UBound(flds)
        With pt.PivotFields(flds(i))
            .Orientation = xlRowField
            .Subtotals(1) = False
        End With
    Next i
    pt.PivotFields("Status").Orientation = xlPageField
    pt.ColumnGrand = False
    pt.RowGrand = False
    pt.ManualUpdate = False
    pt.RowAxisLayout xlTabularRow
    pt.RepeatAllLabels xlRepeatLabels
    pt.HasAutoFormat = False
    On Error Resume Next
    pt.PivotFields("Status").CurrentPage = "Ongoing"
    pt.PivotFields("Quarter").AutoSort xlAscending, "Quarter"
    pt.TableStyle2 = "DWS Pivot"
    pt.ShowTableStyleRowStripes = True
    Err.Clear
    On Error GoTo 0
End Sub

Private Function NewCache(wb As Workbook, srcPt As PivotTable, fieldName As String, others As Variant) As SlicerCache
    Dim sc As SlicerCache
    Dim i As Long
    Set sc = wb.SlicerCaches.Add2(srcPt, fieldName)
    For i = LBound(others) To UBound(others)
        sc.PivotTables.AddPivotTable others(i)
    Next i
    Set NewCache = sc
End Function

Private Function IsIn(ByVal v As String, arr As Variant) As Boolean
    Dim x As Variant
    For Each x In arr
        If CStr(x) = v Then
            IsIn = True
            Exit Function
        End If
    Next x
    IsIn = False
End Function

Private Sub SelectOnly(sc As SlicerCache, keep As Variant)
    Dim it As SlicerItem
    Dim hit As Boolean
    On Error Resume Next
    hit = False
    For Each it In sc.SlicerItems
        If IsIn(it.Name, keep) Then
            it.Selected = True
            hit = True
        End If
    Next it
    If hit Then
        For Each it In sc.SlicerItems
            If Not IsIn(it.Name, keep) Then it.Selected = False
        Next it
    End If
    Err.Clear
    On Error GoTo 0
End Sub

Private Sub Deselect(sc As SlicerCache, drop As Variant)
    Dim it As SlicerItem
    On Error Resume Next
    For Each it In sc.SlicerItems
        If IsIn(it.Name, drop) Then it.Selected = False
    Next it
    Err.Clear
    On Error GoTo 0
End Sub

Private Sub PlaceFilters(ws As Worksheet, caches As Variant, caps As Variant, nms As Variant, scTL As SlicerCache)
    Const BTN_W As Double = 70
    Const SL_H As Double = 62
    Const GAP_X As Double = 10
    Const GAP_Y As Double = 8
    Const TL_H As Double = 80
    Dim x0 As Double
    Dim y0 As Double
    Dim xMax As Double
    Dim x As Double
    Dim y As Double
    Dim w As Double
    Dim i As Long
    Dim n As Long
    Dim xs() As Double
    Dim ys() As Double
    Dim wd() As Double
    Dim sc As SlicerCache
    Dim s As Slicer
    Dim tlTop As Double
    Dim bandTop As Double
    Dim per As Double

    x0 = ws.Range("B8").Left + 6
    y0 = ws.Range("B8").Top + 4
    xMax = ws.Range("AW8").Left + ws.Range("AW8").Width - 6
    ReDim xs(LBound(caches) To UBound(caches))
    ReDim ys(LBound(caches) To UBound(caches))
    ReDim wd(LBound(caches) To UBound(caches))

    ' 1) work out where each filter goes (flows onto a new row when full)
    x = x0
    y = y0
    For i = LBound(caches) To UBound(caches)
        Set sc = caches(i)
        n = sc.SlicerItems.Count
        If n < 1 Then n = 1
        w = n * (BTN_W + 6) + 16
        If w > xMax - x0 Then w = xMax - x0
        If x + w > xMax And x > x0 Then
            x = x0
            y = y + SL_H + GAP_Y
        End If
        xs(i) = x
        ys(i) = y
        wd(i) = w
        x = x + w + GAP_X
    Next i
    tlTop = y + SL_H + GAP_Y

    ' 2) stretch the light band (rows 8 to 21) so everything fits inside it
    bandTop = ws.Range("B8").Top
    per = (tlTop + TL_H + 8 - bandTop) / 14
    If per < 12 Then per = 12
    If per > 400 Then per = 400
    ws.Range("8:21").RowHeight = per

    ' 3) add the slicers and the timeline
    For i = LBound(caches) To UBound(caches)
        Set sc = caches(i)
        n = sc.SlicerItems.Count
        If n < 1 Then n = 1
        Set s = sc.Slicers.Add(ws, , CStr(nms(i)), CStr(caps(i)), ys(i), xs(i), wd(i), SL_H)
        On Error Resume Next
        s.Style = "DWS Slicer"
        s.NumberOfColumns = n
        s.ColumnWidth = BTN_W
        s.RowHeight = 20
        s.DisplayHeader = True
        Err.Clear
        On Error GoTo 0
    Next i

    Set s = scTL.Slicers.Add(ws, , "tlDate", "Launch date / target date", tlTop, x0, xMax - x0, TL_H)
    On Error Resume Next
    s.Style = "DWS Timeline"
    s.TimelineViewState.Level = 1       ' 1 = quarters
    Err.Clear
    On Error GoTo 0
End Sub

Private Sub MakeStyles(wb As Workbook)
    Dim st As TableStyle
    On Error Resume Next
    wb.TableStyles("DWS Slicer").Delete
    wb.TableStyles("DWS Timeline").Delete
    wb.TableStyles("DWS Pivot").Delete
    Err.Clear

    Set st = Nothing
    Set st = wb.TableStyles("SlicerStyleLight1").Duplicate("DWS Slicer")
    If Not st Is Nothing Then
        With st
            .TableStyleElements(xlWholeTable).Interior.Color = vbWhite
            .TableStyleElements(xlHeaderRow).Font.Color = NAVY
            .TableStyleElements(xlHeaderRow).Font.Bold = True
            .TableStyleElements(30).Interior.Color = NAVY                 ' selected item with data
            .TableStyleElements(30).Font.Color = vbWhite
            .TableStyleElements(28).Interior.Color = LIGHT                ' unselected item with data
            .TableStyleElements(28).Font.Color = NAVY
            .TableStyleElements(29).Interior.Color = RGB(250, 250, 250)   ' unselected, no data
            .TableStyleElements(29).Font.Color = RGB(170, 170, 170)
            .TableStyleElements(31).Interior.Color = RGB(120, 132, 160)   ' selected, no data
            .TableStyleElements(31).Font.Color = vbWhite
            .TableStyleElements(33).Interior.Color = RGB(31, 58, 138)     ' hovered, selected
            .TableStyleElements(33).Font.Color = vbWhite
            .TableStyleElements(32).Interior.Color = PALEBLUE             ' hovered, unselected
            .TableStyleElements(32).Font.Color = NAVY
        End With
    End If

    Set st = Nothing
    Set st = wb.TableStyles("TimeSlicerStyleLight1").Duplicate("DWS Timeline")
    If Not st Is Nothing Then
        With st
            .TableStyleElements(xlWholeTable).Interior.Color = vbWhite
            .TableStyleElements(xlHeaderRow).Font.Color = NAVY
            .TableStyleElements(xlHeaderRow).Font.Bold = True
            .TableStyleElements(36).Font.Color = NAVY            ' selection label
            .TableStyleElements(37).Font.Color = NAVY            ' time level
            .TableStyleElements(38).Font.Color = MIDGREY         ' period labels 1
            .TableStyleElements(39).Font.Color = MIDGREY         ' period labels 2
            .TableStyleElements(40).Interior.Color = NAVY        ' selected time block
            .TableStyleElements(41).Interior.Color = LIGHT       ' unselected time block
            .TableStyleElements(42).Interior.Color = PALEBLUE    ' selected time block space
        End With
    End If

    Set st = Nothing
    Set st = wb.TableStyles("PivotStyleLight16").Duplicate("DWS Pivot")
    If Not st Is Nothing Then
        With st
            .TableStyleElements(xlHeaderRow).Interior.Color = NAVY
            .TableStyleElements(xlHeaderRow).Font.Color = vbWhite
            .TableStyleElements(xlHeaderRow).Font.Bold = True
            .TableStyleElements(xlRowStripe1).Interior.Color = LIGHT
        End With
    End If
    Err.Clear
    On Error GoTo 0
End Sub

Private Function GPD(ByVal sideName As String, ByVal period As String) As String
    GPD = "IFERROR(GETPIVOTDATA(`Events`,Calc!$B$4,`Side`,`" & sideName & "`,`Period`,`" & period & "`),0)"
End Function

Private Sub LayoutDashboard(ws As Worksheet, hdrRow As Long)
    Dim i As Long
    Dim k As Long
    Dim r As Long
    Dim c As Long
    Dim s As Long
    Dim c0 As Long
    Dim acc As Long
    Dim sideName As String
    Dim starts As Variant
    Dim heads As Variant
    Dim a As String
    Dim yr As String
    Dim dot As String

    yr = "Calc!$AE$3"
    dot = "     " & ChrW(183) & "     "

    ws.Cells.Font.Size = 10
    ws.Cells.Font.Color = DARKTXT
    ws.Columns(1).ColumnWidth = 1.5
    ws.Range(ws.Columns(2), ws.Columns(49)).ColumnWidth = 2.71
    ws.Columns(50).ColumnWidth = 1.5

    ws.Rows(1).RowHeight = 8
    ws.Rows(2).RowHeight = 30
    ws.Rows(3).RowHeight = 20
    ws.Rows(4).RowHeight = 8
    ws.Rows(5).RowHeight = 18
    ws.Rows(6).RowHeight = 8
    ws.Rows(7).RowHeight = 18
    ws.Range("8:21").RowHeight = 15
    ws.Rows(22).RowHeight = 16
    ws.Rows(23).RowHeight = 8
    ws.Rows(24).RowHeight = 26
    ws.Rows(25).RowHeight = 8
    ws.Rows(26).RowHeight = 20
    ws.Rows(27).RowHeight = 18
    ws.Rows(28).RowHeight = 40
    ws.Rows(29).RowHeight = 16
    ws.Rows(30).RowHeight = 8
    ws.Rows(31).RowHeight = 16
    ws.Rows(32).RowHeight = 14
    ws.Rows(33).RowHeight = 20
    ws.Rows(34).RowHeight = 12
    ws.Range("35:50").RowHeight = 15
    ws.Rows(51).RowHeight = 12
    ws.Rows(52).RowHeight = 22
    ws.Rows(53).RowHeight = 18
    ws.Range(ws.Rows(54), ws.Rows(53 + LIST_ROWS)).RowHeight = 16
    ws.Rows(54 + LIST_ROWS).RowHeight = 16

    ' --- title band
    ws.Range("B2:AW3").Interior.Color = NAVY
    With ws.Range("B2")
        .Value = "Product Launch Dashboard"
        .Font.Size = 20
        .Font.Bold = True
        .Font.Color = vbWhite
        .VerticalAlignment = xlBottom
    End With
    With ws.Range("B3")
        .Value = "PPWS" & dot & "Xtrackers (passive) and Active (DWS)" & dot & "launches and pipeline"
        .Font.Size = 10
        .Font.Color = RGB(200, 208, 230)
    End With
    With ws.Range("AW2")
        .Value = "For internal use only"
        .HorizontalAlignment = xlRight
        .Font.Size = 9
        .Font.Color = vbWhite
    End With

    ' --- as-at line
    With ws.Range("B5")
        .Value = "DATA AS AT"
        .Font.Bold = True
        .Font.Size = 9
        .Font.Color = NAVY
    End With
    AsAtPair ws, "H5", "Product master", "M5:P5", "Product master"
    AsAtPair ws, "R5", "PLM", "U5:X5", "PLM"
    AsAtPair ws, "Z5", "Active list", "AE5:AH5", "Active list"
    AsAtPair ws, "AJ5", "Refreshed", "AO5:AR5", "Refreshed"

    ' --- filter band (slicers are placed on top of it later)
    ws.Range("B7:AW21").Interior.Color = LIGHT
    With ws.Range("B7")
        .Value = "VIEW OPTIONS  (FILTERING)"
        .Font.Bold = True
        .Font.Size = 9
        .Font.Color = NAVY
    End With
    With ws.Range("B22")
        .Value = "Default view: fund launches. Share classes and repositionings are switched off - click them in the filters to add them. Business line: both selected = PPWS."
        .Font.Italic = True
        .Font.Size = 8
        .Font.Color = MIDGREY
    End With

    ' --- PPWS total line
    With ws.Range("B24:AW24")
        .Merge
        .Interior.Color = PALEBLUE
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .Font.Bold = True
        .Font.Size = 12
        .Font.Color = NAVY
    End With
    ws.Range("B24").Formula = FQ("=`PPWS TOTAL" & dot & "`&(B28+AA28)&` completed YTD" & dot & "`&(J28+AI28)&` in pipeline `&" & yr & _
        "&`" & dot & "`&(R28+AQ28)&` in pipeline `&(" & yr & "+1)")

    ' --- side headers, KPI tiles and live products
    SideHeader ws.Range("B26:X26"), "PASSIVE" & dot & "XTRACKERS", ORANGE
    SideHeader ws.Range("AA26:AW26"), "ACTIVE" & dot & "DWS", NAVY
    For s = 0 To 1
        If s = 0 Then
            sideName = "Passive"
            c0 = 2
            acc = ORANGE
        Else
            sideName = "Active"
            c0 = 27
            acc = NAVY
        End If
        Tile ws, c0, c0 + 6, "Completed YTD", FQ("=" & GPD(sideName, "Completed YTD")), "since 1 January", acc
        Tile ws, c0 + 8, c0 + 14, FQ("=`Pipeline `&" & yr), _
            FQ("=" & GPD(sideName, "Pipeline this year") & "+" & GPD(sideName, "Pipeline overdue")), "ongoing, target this year", acc
        Tile ws, c0 + 16, c0 + 22, FQ("=`Pipeline `&(" & yr & "+1)"), _
            FQ("=" & GPD(sideName, "Pipeline next year")), "ongoing, target next year", acc

        With ws.Cells(31, c0)
            .Value = "LIVE PRODUCTS  (product master, status Active)"
            .Font.Size = 8
            .Font.Bold = True
            .Font.Color = MIDGREY
        End With
        For k = 0 To 3
            c = c0 + 6 * k
            LiveStat ws, c, c + 4, CStr(Choose(k + 1, "ETFs", "ETCs", "Funds", "Share classes")), sideName, _
                CStr(Choose(k + 1, "ETF", "ETC", "Fund", "Share class")), acc
        Next k
    Next s

    ' --- upcoming initiatives (mirrors the Initiatives tab)
    With ws.Range("B52:AW52")
        .Merge
        .Interior.Color = NAVY
        .Font.Color = vbWhite
        .Font.Bold = True
        .Font.Size = 10
        .HorizontalAlignment = xlLeft
        .VerticalAlignment = xlCenter
    End With
    ws.Range("B52").Value = "UPCOMING INITIATIVES" & dot & "ongoing items that match the filters and the timeline (full list on the Initiatives tab)"

    starts = Array(2, 6, 11, 28, 33, 38, 42, 45)
    heads = Array("Quarter", "Business line", "Product name", "Product type", "Event type", "Region", "SFDR", "Asset class")
    ws.Range("B53:AW53").Interior.Color = PALEBLUE
    For i = 0 To 7
        With ws.Cells(53, starts(i))
            .Value = heads(i)
            .Font.Bold = True
            .Font.Size = 9
            .Font.Color = NAVY
        End With
    Next i
    For k = 1 To LIST_ROWS
        r = 53 + k
        If k Mod 2 = 0 Then ws.Range(ws.Cells(r, 2), ws.Cells(r, 49)).Interior.Color = LIGHT
        For i = 0 To 7
            a = "Initiatives!$" & Chr(Asc("B") + i) & "$" & (hdrRow + k)
            With ws.Cells(r, starts(i))
                .Formula = FQ("=IF(OR(" & a & "=``," & a & "=`(blank)`),``," & a & ")")
                .Font.Size = 9
                If i = 0 Then
                    .Font.Bold = True
                    .Font.Color = NAVY
                End If
            End With
        Next i
    Next k
    a = "COUNTA(Initiatives!$D$" & (hdrRow + 1) & ":$D$5000)"
    With ws.Cells(54 + LIST_ROWS, 2)
        .Formula = FQ("=IF(" & a & ">" & LIST_ROWS & ",`+ `&(" & a & "-" & LIST_ROWS & ")&` more on the Initiatives tab`,``)")
        .Font.Italic = True
        .Font.Size = 8
        .Font.Color = MIDGREY
    End With
End Sub

Private Sub AsAtPair(ws As Worksheet, lblAddr As String, lbl As String, valAddr As String, key As String)
    With ws.Range(lblAddr)
        .Value = lbl
        .Font.Size = 9
        .Font.Color = MIDGREY
    End With
    With ws.Range(valAddr)
        .Merge
        .NumberFormat = "dd mmm yyyy"
        .HorizontalAlignment = xlLeft
        .Font.Size = 9
        .Font.Bold = True
        .Font.Color = NAVY
    End With
    ws.Range(valAddr).Cells(1, 1).Formula = FQ("=IFERROR(INDEX(tblAsAt[As at],MATCH(`" & key & "`,tblAsAt[Source],0)),``)")
End Sub

Private Sub SideHeader(rng As Range, t As String, clr As Long)
    rng.Merge
    rng.Interior.Color = clr
    rng.Cells(1, 1).Value = t
    rng.Font.Bold = True
    rng.Font.Size = 10
    rng.Font.Color = vbWhite
    rng.HorizontalAlignment = xlCenter
    rng.VerticalAlignment = xlCenter
End Sub

Private Sub Tile(ws As Worksheet, c1 As Long, c2 As Long, lbl As String, valFormula As String, cap As String, acc As Long)
    Dim rL As Range
    Dim rV As Range
    Dim rC As Range
    Set rL = ws.Range(ws.Cells(27, c1), ws.Cells(27, c2))
    Set rV = ws.Range(ws.Cells(28, c1), ws.Cells(28, c2))
    Set rC = ws.Range(ws.Cells(29, c1), ws.Cells(29, c2))
    ws.Range(ws.Cells(27, c1), ws.Cells(29, c2)).Interior.Color = LIGHT
    rL.Merge
    rV.Merge
    rC.Merge
    rL.Cells(1, 1).Formula = lbl
    rV.Cells(1, 1).Formula = valFormula
    rC.Cells(1, 1).Value = cap
    rL.HorizontalAlignment = xlCenter
    rV.HorizontalAlignment = xlCenter
    rC.HorizontalAlignment = xlCenter
    rL.VerticalAlignment = xlBottom
    rV.VerticalAlignment = xlCenter
    rC.VerticalAlignment = xlTop
    rL.Font.Size = 9
    rL.Font.Bold = True
    rL.Font.Color = MIDGREY
    rV.Font.Size = 26
    rV.Font.Bold = True
    rV.Font.Color = acc
    rV.NumberFormat = "#,##0"
    rC.Font.Size = 8
    rC.Font.Color = MIDGREY
    With rL.Borders(xlEdgeTop)
        .LineStyle = xlContinuous
        .Weight = xlThick
        .Color = acc
    End With
End Sub

Private Sub LiveStat(ws As Worksheet, c1 As Long, c2 As Long, lbl As String, sideName As String, ptype As String, acc As Long)
    Dim rL As Range
    Dim rV As Range
    Set rL = ws.Range(ws.Cells(32, c1), ws.Cells(32, c2))
    Set rV = ws.Range(ws.Cells(33, c1), ws.Cells(33, c2))
    rL.Merge
    rV.Merge
    rL.Cells(1, 1).Value = lbl
    rV.Cells(1, 1).Formula = FQ("=SUMIFS(tblLive[Live],tblLive[Side],`" & sideName & "`,tblLive[Product type],`" & ptype & "`)")
    rL.HorizontalAlignment = xlCenter
    rV.HorizontalAlignment = xlCenter
    rL.Font.Size = 8
    rL.Font.Color = MIDGREY
    rV.Font.Size = 12
    rV.Font.Bold = True
    rV.Font.Color = acc
    rV.NumberFormat = "#,##0"
    With rV.Borders(xlEdgeBottom)
        .LineStyle = xlContinuous
        .Weight = xlThin
        .Color = LINEC
    End With
End Sub

Private Sub MakeCharts(ws As Worksheet, ptPie As PivotTable, ptQ As PivotTable)
    Dim co As ChartObject
    Dim L As Double
    Dim T As Double
    Dim W As Double
    Dim H As Double
    Dim i As Long
    Dim cats As Variant

    T = ws.Range("B35").Top
    H = ws.Range("B51").Top - T - 4

    ' doughnut: active vs passive
    L = ws.Range("B35").Left
    W = ws.Range("Q35").Left - L - 6
    Set co = ws.ChartObjects.Add(L, T, W, H)
    co.Name = "chActivePassive"
    co.Chart.SetSourceData Source:=ptPie.TableRange1
    co.Chart.ChartType = xlDoughnut
    co.Chart.HasTitle = True
    co.Chart.ChartTitle.Text = "Active vs passive share"
    StyleChart co.Chart
    On Error Resume Next
    co.Chart.ShowAllFieldButtons = False
    co.Chart.ChartGroups(1).DoughnutHoleSize = 55
    co.Chart.HasLegend = True
    co.Chart.Legend.Position = xlLegendPositionBottom
    With co.Chart.SeriesCollection(1)
        .HasDataLabels = True
        .DataLabels.ShowPercentage = True
        .DataLabels.ShowValue = False
        .DataLabels.ShowCategoryName = False
        .DataLabels.Font.Color = vbWhite
        .DataLabels.Font.Bold = True
        cats = .XValues
        For i = LBound(cats) To UBound(cats)
            If CStr(cats(i)) = "Passive" Then
                .Points(i - LBound(cats) + 1).Format.Fill.ForeColor.RGB = ORANGE
            Else
                .Points(i - LBound(cats) + 1).Format.Fill.ForeColor.RGB = NAVY
            End If
        Next i
    End With
    Err.Clear
    On Error GoTo 0

    ' stacked columns by quarter
    L = ws.Range("R35").Left
    W = ws.Range("AW35").Left + ws.Range("AW35").Width - L
    Set co = ws.ChartObjects.Add(L, T, W, H)
    co.Name = "chByQuarter"
    co.Chart.SetSourceData Source:=ptQ.TableRange1
    co.Chart.ChartType = xlColumnStacked
    co.Chart.HasTitle = True
    co.Chart.ChartTitle.Text = "Completed and pipeline by quarter (filters + timeline)"
    StyleChart co.Chart
    On Error Resume Next
    co.Chart.ShowAllFieldButtons = False
    co.Chart.HasLegend = True
    co.Chart.Legend.Position = xlLegendPositionTop
    co.Chart.ChartGroups(1).GapWidth = 60
    For i = 1 To co.Chart.SeriesCollection.Count
        With co.Chart.SeriesCollection(i)
            If .Name = "Passive" Then
                .Format.Fill.ForeColor.RGB = ORANGE
            Else
                .Format.Fill.ForeColor.RGB = NAVY
            End If
            .HasDataLabels = True
            .DataLabels.Font.Color = vbWhite
            .DataLabels.Font.Size = 8
        End With
    Next i
    co.Chart.Axes(xlValue).MajorGridlines.Format.Line.ForeColor.RGB = LINEC
    Err.Clear
    On Error GoTo 0
End Sub

Private Sub StyleChart(ch As Chart)
    On Error Resume Next
    ch.ChartArea.Format.Line.Visible = False
    ch.ChartArea.Font.Size = 9
    ch.ChartArea.Font.Color = DARKTXT
    ch.ChartTitle.Font.Size = 11
    ch.ChartTitle.Font.Bold = True
    ch.ChartTitle.Font.Color = NAVY
    Err.Clear
    On Error GoTo 0
End Sub

Private Sub FormatInitiatives(ws As Worksheet)
    ws.Columns("A").ColumnWidth = 2
    ws.Columns("B").ColumnWidth = 11
    ws.Columns("C").ColumnWidth = 13
    ws.Columns("D").ColumnWidth = 60
    ws.Columns("E").ColumnWidth = 13
    ws.Columns("F").ColumnWidth = 15
    ws.Columns("G").ColumnWidth = 11
    ws.Columns("H").ColumnWidth = 10
    ws.Columns("I").ColumnWidth = 16
    With ws.Range("B2")
        .Value = "Upcoming initiatives"
        .Font.Size = 16
        .Font.Bold = True
        .Font.Color = NAVY
    End With
    With ws.Range("B3")
        .Value = "Ongoing items only. Follows the filters and the timeline on the Dashboard tab."
        .Font.Color = MIDGREY
    End With
    ws.Activate
    ActiveWindow.DisplayGridlines = False
End Sub

Private Sub FormatData(ws As Worksheet)
    On Error Resume Next
    With ws.ListObjects("tblEvents")
        .TableStyle = "TableStyleLight9"
        .Range.Columns.AutoFit
    End With
    ws.Tab.Color = MIDGREY
    Err.Clear
    On Error GoTo 0
End Sub

'==========================================================================
' POWER QUERY CODE (M). Backticks are turned into double quotes.
'==========================================================================
Private Function MHelpers() As String
    Dim s As String
    Ln s, "    Rec = (rc as record) as text =>"
    Ln s, "        let"
    Ln s, "            f = List.First(List.Select({`Title`, `Value`, `LookupValue`, `Label`, `Name`, `Email`}, each Record.HasFields(rc, _)), null),"
    Ln s, "            x = if f = null then null else Record.Field(rc, f)"
    Ln s, "        in"
    Ln s, "            if x = null then `` else if x is text then Text.Trim(x)"
    Ln s, "            else if x is list then Text.Combine(List.Transform(x, each try Text.From(_) otherwise ``), `, `)"
    Ln s, "            else (try Text.From(x) otherwise ``),"
    Ln s, "    Txt1 = (x as any) as text =>"
    Ln s, "        if x = null then `` else if x is record then Rec(x) else if x is text then Text.Trim(x) else (try Text.From(x) otherwise ``),"
    Ln s, "    Txt = (v as any) as text =>"
    Ln s, "        if v = null then ``"
    Ln s, "        else if v is text then Text.Trim(v)"
    Ln s, "        else if v is number then Number.ToText(v, `0.##########`)"
    Ln s, "        else if v is list then Text.Combine(List.Transform(v, Txt1), `, `)"
    Ln s, "        else if v is record then Rec(v)"
    Ln s, "        else (try Text.Trim(Text.From(v)) otherwise ``),"
    Ln s, "    U = (v as any) as text => Text.Upper(Txt(v)),"
    Ln s, "    Get = (rc as record, names as list) as any =>"
    Ln s, "        let f = List.First(List.Select(names, each Record.HasFields(rc, _)), null)"
    Ln s, "        in if f = null then null else Record.Field(rc, f),"
    Ln s, "    ToDate = (v as any, culture as text) as nullable date =>"
    Ln s, "        if v = null then null"
    Ln s, "        else if v is date then v"
    Ln s, "        else if v is datetime then DateTime.Date(v)"
    Ln s, "        else if v is datetimezone then DateTime.Date(DateTimeZone.RemoveZone(v))"
    Ln s, "        else if v is number then (try Date.From(v) otherwise null)"
    Ln s, "        else"
    Ln s, "            let t = Txt(v)"
    Ln s, "            in if t = `` then null"
    Ln s, "               else (try Date.FromText(t, culture) otherwise (try DateTime.Date(DateTime.FromText(t, culture)) otherwise null)),"
    Ln s, "    HasWord = (s as text, w as text) as logical => List.Contains(Text.SplitAny(Text.Upper(s), ` -_/()[],.;:&+`), w),"
    Ln s, "    IsD = (c as text) as logical => List.Contains({`0`..`9`}, c),"
    Ln s, "    DateFromName = (nm as text) as nullable date =>"
    Ln s, "        let"
    Ln s, "            n = Text.Length(nm),"
    Ln s, "            cands = if n < 10 then {} else List.Transform({0 .. n - 10}, each Text.Middle(nm, _, 10)),"
    Ln s, "            ymd = List.Select(cands, (s) => IsD(Text.At(s, 0)) and IsD(Text.At(s, 1)) and IsD(Text.At(s, 2)) and IsD(Text.At(s, 3))"
    Ln s, "                and not IsD(Text.At(s, 4)) and IsD(Text.At(s, 5)) and IsD(Text.At(s, 6)) and not IsD(Text.At(s, 7))"
    Ln s, "                and IsD(Text.At(s, 8)) and IsD(Text.At(s, 9))),"
    Ln s, "            dmy = List.Select(cands, (s) => IsD(Text.At(s, 0)) and IsD(Text.At(s, 1)) and not IsD(Text.At(s, 2))"
    Ln s, "                and IsD(Text.At(s, 3)) and IsD(Text.At(s, 4)) and not IsD(Text.At(s, 5))"
    Ln s, "                and IsD(Text.At(s, 6)) and IsD(Text.At(s, 7)) and IsD(Text.At(s, 8)) and IsD(Text.At(s, 9))),"
    Ln s, "            d1 = if List.IsEmpty(ymd) then null else (try #date(Number.From(Text.Start(ymd{0}, 4)), Number.From(Text.Middle(ymd{0}, 5, 2)), Number.From(Text.Middle(ymd{0}, 8, 2))) otherwise null),"
    Ln s, "            d2 = if List.IsEmpty(dmy) then null else (try #date(Number.From(Text.Middle(dmy{0}, 6, 4)), Number.From(Text.Middle(dmy{0}, 3, 2)), Number.From(Text.Start(dmy{0}, 2))) otherwise null)"
    Ln s, "        in if d1 <> null then d1 else d2,"
    Ln s, "    QInfo = (t as text, fy as nullable number) as record =>"
    Ln s, "        let"
    Ln s, "            toks = List.Select(Text.SplitAny(Text.Upper(t), ` /-_,;.()`), each _ <> ``),"
    Ln s, "            qTok = List.First(List.Select(toks, each Text.Length(_) = 2 and Text.Start(_, 1) = `Q` and List.Contains({`1`, `2`, `3`, `4`}, Text.End(_, 1))), null),"
    Ln s, "            yTok = List.First(List.Select(toks, each Text.Length(_) = 4 and List.AllTrue(List.Transform(Text.ToList(_), IsD))), null),"
    Ln s, "            y = if yTok <> null then Number.From(yTok) else fy,"
    Ln s, "            q = if qTok <> null then Number.From(Text.End(qTok, 1)) else null,"
    Ln s, "            d = if y = null then null else if q = null then #date(y, 12, 31) else Date.EndOfMonth(#date(y, q * 3, 1)),"
    Ln s, "            lbl = if y = null then null else if q = null then Text.From(y) & ` TBC` else Text.From(y) & ` Q` & Text.From(q)"
    Ln s, "        in [Date = d, Label = lbl],"
    Ln s, "    Cfg = (nm as text) as text =>"
    Ln s, "        let v = try Excel.CurrentWorkbook(){[Name = nm]}[Content]{0}[Column1] otherwise null"
    Ln s, "        in if v = null then `` else Txt(v),"
    Ln s, "    MapList = List.Buffer(List.Transform(Table.ToRecords(Excel.CurrentWorkbook(){[Name = `tblMap`]}[Content]), each ["
    Ln s, "        K = Text.Upper(Txt(Record.FieldOrDefault(_, `Field`, null))) & `|` & U(Record.FieldOrDefault(_, `Source value`, null)),"
    Ln s, "        To = Txt(Record.FieldOrDefault(_, `Maps to`, null)),"
    Ln s, "        Inc = U(Record.FieldOrDefault(_, `Include`, null)) <> `NO`])),"
    Ln s, "    Map = (fld as text, v as any) as record =>"
    Ln s, "        let"
    Ln s, "            key = Text.Upper(fld) & `|` & U(v),"
    Ln s, "            hit = List.First(List.Select(MapList, each [K] = key), null)"
    Ln s, "        in if hit = null then [Found = false, To = null, Include = false] else [Found = true, To = hit[To], Include = hit[Inc]],"
    Ln s, "    RegionOf = (v as any) as text =>"
    Ln s, "        let r0 = Txt(v), m = Map(`Region`, r0)"
    Ln s, "        in if m[Found] then m[To] else if r0 = `` then `n/a` else r0,"
    Ln s, "    Dec = (s as text) as text => List.Accumulate({{`%2F`, `/`}, {`%2f`, `/`}, {`%20`, ` `}, {`%26`, `&`}, {`%28`, `(`}, {`%29`, `)`},"
    Ln s, "        {`%2C`, `,`}, {`%2c`, `,`}, {`%5F`, `_`}, {`%5f`, `_`}, {`%2D`, `-`}, {`%2d`, `-`}, {`%2E`, `.`}, {`%2e`, `.`},"
    Ln s, "        {`%27`, `'`}, {`%25`, `%`}}, s, (acc, p) => Text.Replace(acc, p{0}, p{1})),"
    Ln s, "    PathInfo = (u as text) as record =>"
    Ln s, "        let"
    Ln s, "            t0 = Text.Trim(u),"
    Ln s, "            hasQ = Text.Contains(t0, `?`),"
    Ln s, "            base = if hasQ then Text.BeforeDelimiter(t0, `?`) else t0,"
    Ln s, "            qry = if hasQ then Text.AfterDelimiter(t0, `?`) else ``,"
    Ln s, "            idp = List.First(List.Select(Text.Split(qry, `&`), each Text.StartsWith(Text.Lower(_), `id=`)), null),"
    Ln s, "            parts = Text.Split(base, `/`),"
    Ln s, "            host = Text.Combine(List.FirstN(parts, 3), `/`),"
    Ln s, "            rawPath = if idp <> null then Dec(Text.AfterDelimiter(idp, `=`)) else Dec(Text.Combine(List.Skip(parts, 3), `/`)),"
    Ln s, "            segs0 = List.Select(Text.Split(rawPath, `/`), each _ <> ``),"
    Ln s, "            segs1 = if List.Count(segs0) > 2 and Text.StartsWith(segs0{0}, `:`) then List.Skip(segs0, 2) else segs0,"
    Ln s, "            formsPos = List.PositionOf(segs1, `Forms`),"
    Ln s, "            segs = if formsPos >= 0 then List.FirstN(segs1, formsPos) else segs1,"
    Ln s, "            bad = List.Contains(List.Transform(segs, Text.Lower), `_layouts`) or List.Count(segs) < 2,"
    Ln s, "            last = if List.IsEmpty(segs) then `` else List.Last(segs),"
    Ln s, "            isFile = List.Contains({`xlsx`, `xlsm`, `xlsb`, `xls`}, Text.Lower(Text.AfterDelimiter(last, `.`, {0, RelativePosition.FromEnd}))),"
    Ln s, "            folder = if isFile then List.RemoveLastN(List.Skip(segs, 2), 1) else List.Skip(segs, 2)"
    Ln s, "        in"
    Ln s, "            if bad then error Error.Record(`Link not supported`, `Paste the folder address bar, or in desktop Excel use File > Info > Copy path for a single file: ` & u)"
    Ln s, "            else [Site = host & `/` & segs{0} & `/` & segs{1}, Path = folder, File = if isFile then last else null],"
    Ln s, "    FolderFiles = (pi as record) as table =>"
    Ln s, "        let"
    Ln s, "            root = SharePoint.Contents(pi[Site], [ApiVersion = 15]),"
    Ln s, "            nav = List.Accumulate(pi[Path], root, (state, nm) =>"
    Ln s, "                let"
    Ln s, "                    hit = Table.SelectRows(state, each [Name] = nm),"
    Ln s, "                    alt = Table.SelectRows(state, each [Name] = `Shared Documents`)"
    Ln s, "                in"
    Ln s, "                    if not Table.IsEmpty(hit) then hit{0}[Content]"
    Ln s, "                    else if nm = `Documents` and not Table.IsEmpty(alt) then alt{0}[Content]"
    Ln s, "                    else error Error.Record(`Folder not found`, `Could not find '` & nm & `' in ` & pi[Site])),"
    Ln s, "            withExt = Table.AddColumn(nav, `_ext`, each Text.Lower(Text.AfterDelimiter([Name], `.`, {0, RelativePosition.FromEnd}))),"
    Ln s, "            files = Table.SelectRows(withExt, each List.Contains({`xlsx`, `xlsm`, `xlsb`, `xls`}, [_ext]) and not Text.StartsWith([Name], `~$`))"
    Ln s, "        in files,"
    Ln s, "    PickFile = (files as table, exactName as nullable text, contains as text) as record =>"
    Ln s, "        let"
    Ln s, "            f1 = if exactName <> null then Table.SelectRows(files, each Text.Lower([Name]) = Text.Lower(exactName))"
    Ln s, "                 else Table.SelectRows(files, each contains = `` or Text.Contains(Text.Lower([Name]), Text.Lower(contains))),"
    Ln s, "            f2 = Table.AddColumn(f1, `_nd`, each DateFromName([Name])),"
    Ln s, "            f3 = Table.AddColumn(f2, `_dm`, each try DateTime.From(Record.Field(_, `Date modified`)) otherwise null),"
    Ln s, "            f4 = Table.Sort(f3, {{`_nd`, Order.Descending}, {`_dm`, Order.Descending}})"
    Ln s, "        in"
    Ln s, "            if Table.IsEmpty(f4) then error Error.Record(`No file found`, if exactName <> null then `The file ` & exactName & ` was not found`"
    Ln s, "                else `No Excel file with '` & contains & `' in its name was found in that folder`)"
    Ln s, "            else f4{0},"
    Ln s, "    GetFile = (link as text, contains as text) as record =>"
    Ln s, "        let pi = PathInfo(link) in PickFile(FolderFiles(pi), pi[File], contains),"
    Ln s, "    FileAsAt = (f as record) as date =>"
    Ln s, "        if f[_nd] <> null then f[_nd] else if f[_dm] <> null then DateTime.Date(f[_dm]) else DateTime.Date(DateTime.LocalNow()),"
    Ln s, "    ReadSheet = (bin as binary, sheet as text) as table =>"
    Ln s, "        let"
    Ln s, "            book = Excel.Workbook(bin, null, true),"
    Ln s, "            hit = Table.SelectRows(book, each [Kind] = `Sheet` and Text.Upper(Text.Trim([Item])) = Text.Upper(Text.Trim(sheet))),"
    Ln s, "            data = if Table.IsEmpty(hit) then error Error.Record(`Sheet not found`, `The sheet '` & sheet & `' was not found in the file`) else hit{0}[Data],"
    Ln s, "            prom = Table.PromoteHeaders(data, [PromoteAllScalars = true]),"
    Ln s, "            clean = Table.TransformColumnNames(prom, each Text.Trim(Text.Clean(_)))"
    Ln s, "        in clean,"
    Ln s, "    Cols = {`Source`, `Side`, `Business line`, `ID`, `Product name`, `Event type`, `Level`, `Product type`, `Status`, `Region`, `SFDR`,"
    Ln s, "        `Asset class`, `Event date`, `Quarter`, `Umbrella`, `Comment`, `_Live`, `_InWindow`, `_Note`, `_AsAt`, `_File`, `_Missing`},"
    MHelpers = s
End Function

Private Function MQ_PM() As String
    Dim s As String
    Ln s, "let"
    s = s & MHelpers()
    Ln s, "    Link = Cfg(`cfg_PM_Link`),"
    Ln s, "    Contains = Cfg(`cfg_PM_FileContains`),"
    Ln s, "    SheetName = Cfg(`cfg_PM_Sheet`),"
    Ln s, "    HistYear = try Number.From(Cfg(`cfg_HistoryFromYear`)) otherwise Date.Year(DateTime.LocalNow()) - 2,"
    Ln s, "    EmptyT = #table(Cols, {}),"
    Ln s, "    Build = () as table =>"
    Ln s, "        let"
    Ln s, "            f = GetFile(Link, Contains),"
    Ln s, "            asAt = FileAsAt(f),"
    Ln s, "            T = ReadSheet(f[Content], if SheetName = `` then `Results` else SheetName),"
    Ln s, "            Expected = {`Product Name`, `Global Product Id`, `Region`, `Business Line`, `Vehicle Type`, `Entry Level`, `Status`, `Compartment/Wrapper`, `Launch Date`},"
    Ln s, "            Missing = Text.Combine(List.Select(Expected, each not List.Contains(Table.ColumnNames(T), _)), `, `),"
    Ln s, "            WinStart = #date(HistYear, 1, 1),"
    Ln s, "            Recs = List.Transform(Table.ToRecords(T), (r) =>"
    Ln s, "                let"
    Ln s, "                    name = Txt(Get(r, {`Product Name`, `Product name`})),"
    Ln s, "                    entry = U(Get(r, {`Entry Level`, `Entry level`})),"
    Ln s, "                    bl = U(Get(r, {`Business Line`, `Business line`})),"
    Ln s, "                    side = if Text.Contains(bl, `PASSIVE`) then `Passive` else if Text.Contains(bl, `ACTIVE`) then `Active` else null,"
    Ln s, "                    level = if Text.Contains(entry, `SHARE`) then `Share class` else if List.Contains({`COMPARTMENT`, `SINGLE FUND`, `SPV`}, entry) then `Fund` else null,"
    Ln s, "                    vt = U(Get(r, {`Vehicle Type`, `Vehicle type`})),"
    Ln s, "                    ptype = if level = `Share class` then `Share class` else if entry = `SPV` or HasWord(name, `ETC`) then `ETC`"
    Ln s, "                        else if HasWord(name, `ETF`) or Text.Contains(vt, `ETF`) then `ETF` else `Fund`,"
    Ln s, "                    d = ToDate(Get(r, {`Launch Date`, `Launch date`}), `en-US`),"
    Ln s, "                    sm = Map(`PM status`, Get(r, {`Status`})),"
    Ln s, "                    gid = Get(r, {`Global Product Id`, `Global Product ID`}),"
    Ln s, "                    id = if gid is number then Number.ToText(gid, `0`) else Txt(gid),"
    Ln s, "                    inWin = d <> null and d >= WinStart and d <= asAt,"
    Ln s, "                    note = if side = null then `Business line not recognised: ` & bl else if level = null then `Entry level not counted: ` & entry else null"
    Ln s, "                in ["
    Ln s, "                    Source = `Product master`, Side = side, #`Business line` = if side = `Passive` then `Xtrackers` else side,"
    Ln s, "                    ID = id, #`Product name` = name, #`Event type` = `Launch`, Level = level, #`Product type` = ptype,"
    Ln s, "                    Status = `Completed`, Region = RegionOf(Get(r, {`Region`})), SFDR = `n/a`, #`Asset class` = `n/a`,"
    Ln s, "                    #`Event date` = d,"
    Ln s, "                    Quarter = if d = null then null else Text.From(Date.Year(d)) & ` Q` & Text.From(Date.QuarterOfYear(d)),"
    Ln s, "                    Umbrella = Txt(Get(r, {`Compartment/Wrapper`})), Comment = ``,"
    Ln s, "                    _Live = sm[Found] and sm[Include], _InWindow = inWin, _Note = note,"
    Ln s, "                    _AsAt = asAt, _File = f[Name], _Missing = Missing]),"
    Ln s, "            Kept = List.Select(Recs, each [_Live] or [_InWindow]),"
    Ln s, "            Out = Table.FromRecords(Kept, Cols, MissingField.UseNull)"
    Ln s, "        in Out,"
    Ln s, "    Result = if Link = `` then EmptyT else Build()"
    Ln s, "in"
    Ln s, "    Result"
    MQ_PM = Replace(s, "`", Chr(34))
End Function

Private Function MQ_PLM() As String
    Dim s As String
    Ln s, "let"
    s = s & MHelpers()
    Ln s, "    Link = Cfg(`cfg_PLM_Link`),"
    Ln s, "    Contains = Cfg(`cfg_PLM_FileContains`),"
    Ln s, "    SheetName = Cfg(`cfg_PLM_Sheet`),"
    Ln s, "    Relevance = Text.Upper(Cfg(`cfg_PLM_Relevance`)),"
    Ln s, "    EmptyT = #table(Cols, {}),"
    Ln s, "    Build = () as table =>"
    Ln s, "        let"
    Ln s, "            f = GetFile(Link, Contains),"
    Ln s, "            asAt = FileAsAt(f),"
    Ln s, "            T = ReadSheet(f[Content], if SheetName = `` then `Events reports` else SheetName),"
    Ln s, "            Expected = {`PGC reference`, `Detailed Event`, `Event Status`, `Product Name`, `Combined Target Date`, `Target Quarter`, `Region`,"
    Ln s, "                `Pipeline Relevance`, `Included in Pipeline as`, `Asset Class`, `Exchange traded/Non-Exchange traded`,"
    Ln s, "                `Name of Umbrella/SICAV Funds`, `ESG Classification (EU Regulation 2019/2088)`, `Global Product Id`},"
    Ln s, "            Missing = Text.Combine(List.Select(Expected, each not List.Contains(Table.ColumnNames(T), _)), `, `),"
    Ln s, "            Recs0 = List.Select(Table.ToRecords(T), (r) => Txt(Get(r, {`Product Name`})) <> `` or Txt(Get(r, {`PGC reference`})) <> ``),"
    Ln s, "            Recs = List.Transform(Recs0, (r) =>"
    Ln s, "                let"
    Ln s, "                    name = Txt(Get(r, {`Product Name`, `Product name`})),"
    Ln s, "                    relTxt = Txt(Get(r, {`Pipeline Relevance`})),"
    Ln s, "                    relOk = Relevance = `` or Text.StartsWith(Text.Upper(relTxt), Relevance),"
    Ln s, "                    ev0 = Txt(Get(r, {`Included in Pipeline as`})),"
    Ln s, "                    evm = Map(`PLM event`, ev0),"
    Ln s, "                    st0 = Txt(Get(r, {`Event Status`})),"
    Ln s, "                    stm = Map(`PLM status`, st0),"
    Ln s, "                    det = U(Get(r, {`Detailed Event`})),"
    Ln s, "                    level = if Text.Contains(det, `SHARE`) then `Share class` else `Fund`,"
    Ln s, "                    exch = U(Get(r, {`Exchange traded/Non-Exchange traded`})),"
    Ln s, "                    ptype = if level = `Share class` then `Share class` else if HasWord(name, `ETC`) then `ETC`"
    Ln s, "                        else if exch = `EXCHANGE TRADED` or HasWord(name, `ETF`) then `ETF` else `Fund`,"
    Ln s, "                    d1 = ToDate(Get(r, {`Combined Target Date`}), `en-GB`),"
    Ln s, "                    d2 = if d1 <> null then d1 else ToDate(Get(r, {`Target Date`}), `en-GB`),"
    Ln s, "                    qi = QInfo(Txt(Get(r, {`Target Quarter`})), null),"
    Ln s, "                    d = if d2 <> null then d2 else qi[Date],"
    Ln s, "                    quarter = if d2 <> null then Text.From(Date.Year(d2)) & ` Q` & Text.From(Date.QuarterOfYear(d2)) else qi[Label],"
    Ln s, "                    esg = U(Get(r, {`ESG Classification (EU Regulation 2019/2088)`, `ESG Classification`})),"
    Ln s, "                    sfdr = if Text.StartsWith(esg, `A6`) or Text.Contains(esg, `ARTICLE 6`) then `Art. 6`"
    Ln s, "                        else if Text.StartsWith(esg, `A8`) or Text.Contains(esg, `ARTICLE 8`) then `Art. 8`"
    Ln s, "                        else if Text.StartsWith(esg, `A9`) or Text.Contains(esg, `ARTICLE 9`) then `Art. 9`"
    Ln s, "                        else `n/a`,"
    Ln s, "                    gid = Get(r, {`Global Product Id`, `Global Product ID`}),"
    Ln s, "                    id0 = if gid is number then Number.ToText(gid, `0`) else Txt(gid),"
    Ln s, "                    id = if id0 <> `` then id0 else Txt(Get(r, {`PGC reference`})),"
    Ln s, "                    c1 = Txt(Get(r, {`Change Event Summary`})),"
    Ln s, "                    c2 = Txt(Get(r, {`Product Event Summary`})),"
    Ln s, "                    ac = Txt(Get(r, {`Asset Class`, `Asset class`})),"
    Ln s, "                    note = if not relOk then `Pipeline Relevance is ` & (if relTxt = `` then `empty` else relTxt)"
    Ln s, "                        else if not evm[Found] then `Event type not in the mapping: ` & ev0"
    Ln s, "                        else if not evm[Include] then `Event type switched off: ` & ev0"
    Ln s, "                        else if not stm[Found] then `Status not in the mapping: ` & st0"
    Ln s, "                        else if not stm[Include] then `Status switched off: ` & st0"
    Ln s, "                        else if d = null then `No target date`"
    Ln s, "                        else null"
    Ln s, "                in ["
    Ln s, "                    Source = `PLM`, Side = `Passive`, #`Business line` = `Xtrackers`,"
    Ln s, "                    ID = id, #`Product name` = name, #`Event type` = evm[To], Level = level, #`Product type` = ptype,"
    Ln s, "                    Status = stm[To], Region = RegionOf(Get(r, {`Region`})), SFDR = sfdr,"
    Ln s, "                    #`Asset class` = if ac = `` then `n/a` else ac,"
    Ln s, "                    #`Event date` = d, Quarter = quarter,"
    Ln s, "                    Umbrella = Txt(Get(r, {`Name of Umbrella/SICAV Funds`})),"
    Ln s, "                    Comment = if c1 <> `` then c1 else c2,"
    Ln s, "                    _Live = false, _InWindow = true, _Note = note,"
    Ln s, "                    _AsAt = asAt, _File = f[Name], _Missing = Missing]),"
    Ln s, "            Out = Table.FromRecords(Recs, Cols, MissingField.UseNull)"
    Ln s, "        in Out,"
    Ln s, "    Result = if Link = `` then EmptyT else Build()"
    Ln s, "in"
    Ln s, "    Result"
    MQ_PLM = Replace(s, "`", Chr(34))
End Function

Private Function MQ_Active() As String
    Dim s As String
    Ln s, "let"
    s = s & MHelpers()
    Ln s, "    Links = List.Select(List.Transform(Text.SplitAny(Cfg(`cfg_Active_Links`), `;#(lf)`), Text.Trim), each _ <> ``),"
    Ln s, "    CatMust = Text.Upper(Cfg(`cfg_Active_Category`)),"
    Ln s, "    NormKey = (t as nullable text) as text => if t = null then `` else Text.Lower(Text.Remove(t, {` `, `_`, `-`})),"
    Ln s, "    ListInfo = (u as text) as record =>"
    Ln s, "        let"
    Ln s, "            t0 = Text.Trim(u),"
    Ln s, "            base = if Text.Contains(t0, `?`) then Text.BeforeDelimiter(t0, `?`) else t0,"
    Ln s, "            parts = Text.Split(base, `/`),"
    Ln s, "            host = Text.Combine(List.FirstN(parts, 3), `/`),"
    Ln s, "            segs0 = List.Select(List.Transform(List.Skip(parts, 3), Dec), each _ <> ``),"
    Ln s, "            segs = if List.Count(segs0) > 2 and Text.StartsWith(segs0{0}, `:`) then List.Skip(segs0, 2) else segs0,"
    Ln s, "            pos = List.PositionOf(List.Transform(segs, Text.Lower), `lists`),"
    Ln s, "            nm = if pos >= 0 and List.Count(segs) > pos + 1 then segs{pos + 1} else null"
    Ln s, "        in [Site = if List.Count(segs) >= 2 then host & `/` & segs{0} & `/` & segs{1} else host, Name = nm],"
    Ln s, "    ListNames = Text.Combine(List.Transform(Links, each Txt(ListInfo(_)[Name])), `; `),"
    Ln s, "    EmptyT = #table(Cols, {}),"
    Ln s, "    Build = () as table =>"
    Ln s, "        let"
    Ln s, "            One = (lk as text) as table =>"
    Ln s, "                let"
    Ln s, "                    li = ListInfo(lk),"
    Ln s, "                    src = SharePoint.Tables(li[Site], [Implementation = `2.0`, ViewMode = `All`]),"
    Ln s, "                    want = NormKey(li[Name]),"
    Ln s, "                    hit = Table.SelectRows(src, each List.AnyTrue(List.Transform(Record.FieldValues(_), (v) => NormKey((try Txt(v) otherwise ``)) = want))),"
    Ln s, "                    items = if li[Name] = null then error Error.Record(`List link not recognised`, `Paste the address bar of the list (it contains /Lists/): ` & lk)"
    Ln s, "                        else if Table.IsEmpty(hit) then error Error.Record(`List not found`, `The list '` & li[Name] & `' was not found on ` & li[Site])"
    Ln s, "                        else hit{0}[Items]"
    Ln s, "                in Table.AddColumn(items, `_List`, each li[Name]),"
    Ln s, "            All = Table.Combine(List.Transform(Links, One)),"
    Ln s, "            Expected = {`Event Type`, `Product Type`, `Region`, `Category`, `Target Quarter`},"
    Ln s, "            Missing = Text.Combine(List.Select(Expected, each not List.Contains(Table.ColumnNames(All), _)), `, `),"
    Ln s, "            Mods = if List.Contains(Table.ColumnNames(All), `Modified`)"
    Ln s, "                then List.RemoveNulls(List.Transform(Table.Column(All, `Modified`), each ToDate(_, `en-GB`))) else {},"
    Ln s, "            asAt = if List.IsEmpty(Mods) then DateTime.Date(DateTime.LocalNow()) else List.Max(Mods),"
    Ln s, "            Recs = List.Transform(Table.ToRecords(All), (r) =>"
    Ln s, "                let"
    Ln s, "                    name = Txt(Get(r, {`Product Name`, `Product name`, `Title`})),"
    Ln s, "                    cat = Txt(Get(r, {`Category`})),"
    Ln s, "                    catOk = CatMust = `` or Text.Contains(Text.Upper(cat), CatMust),"
    Ln s, "                    ev0 = Txt(Get(r, {`Event Type`, `Event type`})),"
    Ln s, "                    evm = Map(`Active event`, ev0),"
    Ln s, "                    pt0 = U(Get(r, {`Product Type`, `Product type`})),"
    Ln s, "                    ptype = if HasWord(name, `ETC`) then `ETC` else if Text.Contains(pt0, `ETF`) or HasWord(name, `ETF`) then `ETF` else `Fund`,"
    Ln s, "                    yToks = List.Select(Text.SplitAny(cat & ` ` & Txt(r[_List]), ` /-_`), each Text.Length(_) = 4 and List.AllTrue(List.Transform(Text.ToList(_), IsD))),"
    Ln s, "                    yFb = if List.IsEmpty(yToks) then null else Number.From(yToks{0}),"
    Ln s, "                    qi = QInfo(Txt(Get(r, {`Target Quarter`, `Target quarter`})), yFb),"
    Ln s, "                    ac = Txt(Get(r, {`Asset class`, `Asset Class`})),"
    Ln s, "                    note = if not catOk then `Category not counted: ` & (if cat = `` then `empty` else cat)"
    Ln s, "                        else if not evm[Found] then `Event type not in the mapping: ` & ev0"
    Ln s, "                        else if not evm[Include] then `Event type switched off: ` & ev0"
    Ln s, "                        else if qi[Date] = null then `No target quarter or year`"
    Ln s, "                        else null"
    Ln s, "                in ["
    Ln s, "                    Source = `Active list`, Side = `Active`, #`Business line` = `Active`,"
    Ln s, "                    ID = Txt(r[_List]) & ` #` & Txt(Get(r, {`ID`, `Id`})),"
    Ln s, "                    #`Product name` = name, #`Event type` = evm[To], Level = `Fund`, #`Product type` = ptype,"
    Ln s, "                    Status = `Ongoing`, Region = RegionOf(Get(r, {`Region`})), SFDR = `n/a`,"
    Ln s, "                    #`Asset class` = if ac = `` then `n/a` else ac,"
    Ln s, "                    #`Event date` = qi[Date], Quarter = qi[Label], Umbrella = ``,"
    Ln s, "                    Comment = Txt(Get(r, {`Comment`, `Comments`})),"
    Ln s, "                    _Live = false, _InWindow = true, _Note = note,"
    Ln s, "                    _AsAt = asAt, _File = ListNames, _Missing = Missing]),"
    Ln s, "            Out = Table.FromRecords(Recs, Cols, MissingField.UseNull)"
    Ln s, "        in Out,"
    Ln s, "    Result = if List.IsEmpty(Links) then EmptyT else Build()"
    Ln s, "in"
    Ln s, "    Result"
    MQ_Active = Replace(s, "`", Chr(34))
End Function

Private Function MQ_Events() As String
    Dim s As String
    Ln s, "let"
    Ln s, "    PM = qPM,"
    Ln s, "    PLM = qPLM,"
    Ln s, "    AL = qActive,"
    Ln s, "    Norm = (t as nullable text) as text => if t = null then `` else Text.Upper(Text.Combine(List.Select(Text.Split(Text.Trim(t), ` `), each _ <> ``), ` `)),"
    Ln s, "    PMAsAt = if Table.IsEmpty(PM) then null else PM{0}[_AsAt],"
    Ln s, "    ReportDate = if PMAsAt <> null then PMAsAt else DateTime.Date(DateTime.LocalNow()),"
    Ln s, "    Y = Date.Year(ReportDate),"
    Ln s, "    PMLaunched = Table.SelectRows(PM, each [_Note] = null and [Event date] <> null and [Event date] <= ReportDate),"
    Ln s, "    LaunchedIDs = List.Buffer(List.Distinct(List.Select(Table.Column(PMLaunched, `ID`), each _ <> null and _ <> ``))),"
    Ln s, "    LaunchedNames = List.Buffer(List.Distinct(List.Transform(Table.Column(Table.SelectRows(PMLaunched,"
    Ln s, "        each [Level] = `Fund` and [Event date] >= Date.AddYears(ReportDate, -1)), `Product name`), Norm))),"
    Ln s, "    PMEv = Table.SelectRows(PM, each [_Note] = null and [_InWindow] = true),"
    Ln s, "    PLMEv = Table.SelectRows(PLM, each [_Note] = null and not ([Event type] = `Launch` and ([Status] = `Completed` or List.Contains(LaunchedIDs, [ID])))),"
    Ln s, "    ALEv = Table.SelectRows(AL, each [_Note] = null and not List.Contains(LaunchedNames, Norm([Product name]))),"
    Ln s, "    Combined = Table.Combine({PMEv, PLMEv, ALEv}),"
    Ln s, "    WithPeriod = Table.AddColumn(Combined, `Period`, each"
    Ln s, "        let yr = if [Event date] = null then null else Date.Year([Event date])"
    Ln s, "        in"
    Ln s, "            if [Status] = `Completed` then (if yr = Y then `Completed YTD` else if yr = Y - 1 then `Completed last year` else `Completed earlier`)"
    Ln s, "            else if yr = null then `Pipeline no date`"
    Ln s, "            else if yr < Y then `Pipeline overdue`"
    Ln s, "            else if yr = Y then `Pipeline this year`"
    Ln s, "            else if yr = Y + 1 then `Pipeline next year`"
    Ln s, "            else `Pipeline later`, type text),"
    Ln s, "    WithCount = Table.AddColumn(WithPeriod, `Count`, each 1, Int64.Type),"
    Ln s, "    Final = Table.SelectColumns(WithCount, {`Business line`, `Side`, `Product name`, `Product type`, `Event type`, `Status`, `Region`, `SFDR`,"
    Ln s, "        `Asset class`, `Event date`, `Quarter`, `Period`, `Level`, `Umbrella`, `Comment`, `Source`, `ID`, `Count`}),"
    Ln s, "    Typed = Table.TransformColumnTypes(Final, {{`Business line`, type text}, {`Side`, type text}, {`Product name`, type text},"
    Ln s, "        {`Product type`, type text}, {`Event type`, type text}, {`Status`, type text}, {`Region`, type text}, {`SFDR`, type text},"
    Ln s, "        {`Asset class`, type text}, {`Event date`, type date}, {`Quarter`, type text}, {`Period`, type text}, {`Level`, type text},"
    Ln s, "        {`Umbrella`, type text}, {`Comment`, type text}, {`Source`, type text}, {`ID`, type text}})"
    Ln s, "in"
    Ln s, "    Typed"
    MQ_Events = Replace(s, "`", Chr(34))
End Function

Private Function MQ_Live() As String
    Dim s As String
    Ln s, "let"
    Ln s, "    PM = qPM,"
    Ln s, "    L = Table.SelectRows(PM, each [_Live] = true and [_Note] = null),"
    Ln s, "    G = Table.Group(L, {`Side`, `Product type`}, {{`Live`, each Table.RowCount(_), Int64.Type}})"
    Ln s, "in"
    Ln s, "    G"
    MQ_Live = Replace(s, "`", Chr(34))
End Function

Private Function MQ_AsAt() As String
    Dim s As String
    Ln s, "let"
    Ln s, "    FirstVal = (t as table, c as text) as any => if Table.IsEmpty(t) then null else Record.Field(t{0}, c),"
    Ln s, "    Nz = (x as any) as text => if x = null then `` else Text.From(x),"
    Ln s, "    PMd = FirstVal(qPM, `_AsAt`),"
    Ln s, "    PLMd = FirstVal(qPLM, `_AsAt`),"
    Ln s, "    ALd = FirstVal(qActive, `_AsAt`),"
    Ln s, "    Report = if PMd <> null then PMd else DateTime.Date(DateTime.LocalNow()),"
    Ln s, "    Stamp = DateTime.LocalNow(),"
    Ln s, "    T = #table(type table [Source = text, #`As at` = nullable date, Detail = text], {"
    Ln s, "        {`Report date`, Report, `Year used for the YTD and pipeline tiles`},"
    Ln s, "        {`Product master`, PMd, Nz(FirstVal(qPM, `_File`))},"
    Ln s, "        {`PLM`, PLMd, Nz(FirstVal(qPLM, `_File`))},"
    Ln s, "        {`Active list`, ALd, Nz(FirstVal(qActive, `_File`))},"
    Ln s, "        {`Refreshed`, DateTime.Date(Stamp), Text.From(DateTime.Time(Stamp))}"
    Ln s, "    })"
    Ln s, "in"
    Ln s, "    T"
    MQ_AsAt = Replace(s, "`", Chr(34))
End Function

Private Function MQ_Checks() As String
    Dim s As String
    Ln s, "let"
    Ln s, "    Pick = (t as table) as table => Table.SelectColumns(Table.SelectRows(t, each [_Note] <> null and [_InWindow] = true), {`Source`, `_Note`}),"
    Ln s, "    Notes = Table.Combine({Pick(qPM), Pick(qPLM), Pick(qActive)}),"
    Ln s, "    Grouped = Table.Group(Notes, {`Source`, `_Note`}, {{`Rows`, each Table.RowCount(_), Int64.Type}}),"
    Ln s, "    Renamed = Table.RenameColumns(Grouped, {{`_Note`, `What was left out`}}),"
    Ln s, "    StatusRows = (t as table, src as text) as list =>"
    Ln s, "        if Table.IsEmpty(t) then {{src, `Nothing loaded - check the link on this tab`, 0}}"
    Ln s, "        else let m = t{0}[_Missing] in if m = null or m = `` then {} else {{src, `Columns not found: ` & m, 0}},"
    Ln s, "    Extra = #table({`Source`, `What was left out`, `Rows`}, StatusRows(qPM, `Product master`) & StatusRows(qPLM, `PLM`) & StatusRows(qActive, `Active list`)),"
    Ln s, "    Out = Table.Combine({Extra, Renamed})"
    Ln s, "in"
    Ln s, "    Out"
    MQ_Checks = Replace(s, "`", Chr(34))
End Function
