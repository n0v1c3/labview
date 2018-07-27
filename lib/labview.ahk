; lib/labview.ahk
; Description: LabVIEW variables and functions
; Author: Travis Gall

; Variables {{{1
; Window Information {{{2
Row := 0
LVWindowInfo := []

Row += 1
LVWindowInfo[Row,1] := "Controls"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Functions"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Project Explorer"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelY
LVWindowInfo[Row,4] := 0
LVWindowInfo[Row,5] := 0
RowPE := Row

; Do NOT resize the Front Panel
Row += 1
LVWindowInfo[Row,1] := "Front Panel"
; LVWindowInfo[Row,2] := rightPanelWidth
; LVWindowInfo[Row,3] := bottomPanelY
; LVWindowInfo[Row,4] := leftPanelWidth
; LVWindowInfo[Row,5] := 0

Row += 1
LVWindowInfo[Row,1] := "Block Diagram"
LVWindowInfo[Row,2] := rightPanelWidth
LVWindowInfo[Row,3] := bottomPanelY
LVWindowInfo[Row,4] := leftPanelWidth
LVWindowInfo[Row,5] := 0

Row += 1
LVWindowInfo[Row,1] := "Probe Watch Window"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Bookmark Manager"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Error list"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "VI Hierarchy"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "LabVIEW Class Hierarchy"
LVWindowInfo[Row,2] := rightPanelWidth - leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := leftPanelWidth * 2
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
LVWindowInfo[Row,1] := "Navigation"
LVWindowInfo[Row,2] := leftPanelWidth
LVWindowInfo[Row,3] := bottomPanelHeight
LVWindowInfo[Row,4] := 0
LVWindowInfo[Row,5] := bottomPanelY

Row += 1
; Do NOT change the size of the Tools window
LVWindowInfo[Row,1] := "Tools"
LVWindowInfo[Row,4] := leftPanelWidth + rightPanelWidth - 115
LVWindowInfo[Row,5] := bottomPanelY - 200

; Functions {{{1
; CurrentBlockDiagrams {{{2
; Get list of open Block Diagrams for a drop-down list
CurrentBlockDiagrams()
{
	WindowList := ""
	isFirst := True

	WinGet windows, List
	Loop %windows%
	{
		id := windows%A_Index%
		WinGetTitle wt, ahk_id %id%
		IfInString, wt, Block Diagram
		{
			WindowList .= (isFirst ? wt "|" : "|" wt)
			isFirst := False
		}
	}
	Return WindowList
}
