<#
# Tab layout and controls shamelessly stolen from:
# MrNetTek
# eddiejackson.net
# 7/15/2022
# free for public use
# free to claim as your own

<# 
.NAME
    Qord's little helper, tabbed edition
.VERSION 
    v2.1
.DESCRIPTION
    Utility to create copyable code for skill descriptions and patch notes
    Code generated from this is meant to replace the three lines of existing skill 
        descriptions that look like this:
        '''Description:''' Summons a powerful Valkyrie ally.'''
        '''Required Level:''' 30
        '''Prerequisites:''' Inner Sight, Phase Run, Decoy
.EXAMPLES
    To use this, open it in powershell and you'll get a gui
    In this gui, paste the proper skill icon url unti the url box
        All icons can be found here: https://pathofdiablo.com/wiki/images
    Copy the original skill description and prerequisites into their textboxes
        If no prereqs you can ignore this line
    Enter the level required
    Click the button to generate code
    Copy it from the textbox on the right and paste it into the wiki for the relevant skill, 
        replacing the existing 3 lines mentioned above

    In this gui, paste the proper patch link
        All patch links can be found here: https://pathofdiablo.com/wiki/index.php?title=Talk:Patch_Notes
    Copy the original narrative patch notes from the skill page into the text box     
    Click the button to generate code
    ### If more than one patch's notes need to be added use the "generate code" button for the newest
        patch changes, and use the "add more patch notes" button to add to the frst one you created
    Copy code from the textbox on the right and paste it into the wiki for the relevant skill, 
        replacing the existing patch notes entry
#>
Function RemoveExtras
{
$TextBoxp5Text = $TextBoxp5Text.trimend("|}")
}
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}
## This is the actual "meat" of the script, the rest is all GUI
## @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## Tab 1 Functions
$handler_button_Click={
$TextBox5.Text = ""
$url = $TextBox1.text
$description = $TextBox2.text
$lvlreq = $TextBox3.text
$prereqs = $TextBox4.text

$skillcode = @"
<!-- If skill doesnt exist in original Diablo 2 remove comment marks below -->
<!-- <span style="color:green">'''New skill'''</span>  -->
{|
|-
|
{| <!-- Description table -->
|rowspan="3" style="vertical-align:top; padding:0.5em 0.5em 0.5em 0.5em; width:5%"|$url ||'''Description:''' $description'''
|-
|'''Required Level:''' $lvlreq
|-
|'''Prerequisites:''' $prereqs
|}
|-
|
"@

$TextBox5.Text += $skillcode
$TextBox5.Select()
$TextBox5.SelectionStart = $TextBox5.Text.Length
$TextBox5.ScrollToCaret()
$TextBox5.Refresh()
sleep -s 1 

$TextBox1.text = ""
$TextBox2.text = ""
$TextBox3.text = ""
}

## Tab 2 Functions

$handler_button_Clickp1={
    $global:state = "need"
    $TextBoxp5.Text = ""
    $patch = $TextBoxp1.text
    $tbox2 = $TextBoxp2.lines
    foreach ($line in $tbox2)
        {
            $line2 = "* " + $line +"`r`n"
            $editedTextBox2 += $line2
        }
    $changes = $editedTextBox2
$patchcode = @"
{| class="wikitable"
! Version Name !!Patch Notes
|-
|$patch||
$changes
|}
"@

    $TextBoxp5.Text += $patchcode
    $TextBoxp5.Select()
    $TextBoxp5.SelectionStart = $TextBox5.Text.Length
    $TextBoxp5.ScrollToCaret()
    $TextBoxp5.Refresh()
    $TextBoxp1.Text = ""
    $TextBoxp2.Text = ""
    sleep -s 1 
    $global:state = "need"
    }

$handler_button_Clickp2=({

    Switch ($global:state) {
        "evenmore"
            {
                $patch = $TextBoxp1.text
                $tbox2 = $TextBoxp2.lines
                $TextBoxp5Text = $TextBoxp5.Text
                $TextBoxp5Text = $TextBoxp5Text.trimend("|}")
                $editedTextBox2 = ""
                foreach ($line in $tbox2)
                    {
                        $line2 = "* " + $line +"`r`n"
                        $editedTextBox2 += $line2
                    }
                $changes4 = $editedTextBox2
$additionsem = @"
|-
|style="border-bottom: 1px solid #a2a9b1;"|$patch||style="border-bottom: 1px solid #a2a9b1;"|
$changes4
"@
                $TextBoxp5Text = $TextBoxp5Text.trimend("|}") <###############################>
                $TextBoxp5Text = $TextBoxp5Text.trimend("|}")
                $TextBoxp5Text = $TextBoxp5Text.replace("|}","")
                #$patchcode3 = ($TextBoxp5Text + $additionsem + "`r`n"+"|}"+ "`r`n"+"|}")
                $patchcode3 = ($TextBoxp5Text + $additionsem + "|}"+ "`r`n"+"|}")

                $TextBoxp5.Text = ""
                $TextBoxp5.Text = $patchcode3
                $TextBoxp5.Select()
                $TextBoxp5.SelectionStart = $TextBox5.Text.Length
                $TextBoxp5.ScrollToCaret()
                $TextBoxp5.Refresh()
                $TextBoxp1.Text = ""
                $TextBoxp2.Text = ""
                $global:state = "evenmore"
            }

        "noneed"
            {
                $patch = $TextBoxp1.text
                $tbox2 = $TextBoxp2.lines
                $TextBoxp5Text = $TextBoxp5.Text
                $editedTextBox2 = ""
                foreach ($line in $tbox2)
                    {
                        $line2 = "* " + $line +"`r`n"
                        $editedTextBox2 += $line2
                    }
                $changes3 = $editedTextBox2

$additionsnn = @"
|-
|style="border-bottom: 1px solid #a2a9b1;"|$patch||style="border-bottom: 1px solid #a2a9b1;"|
$changes3
"@
                $TextBoxp5Text = $TextBoxp5Text.trimend("|}")
                #$patchcode3 = $TextBoxp5Text.Replace("|}", $additionsnn + "`r`n"+"|}" + "`r`n"+"|}")
                $patchcode3 = $TextBoxp5Text.Replace("|}", $additionsnn + "|}" + "`r`n"+"|}")
                $TextBoxp5.Text = ""
                $TextBoxp5.Text += $patchcode3
                $TextBoxp1.Text = ""
                $TextBoxp2.Text = ""
                $global:state = "evenmore"
            }

        "need"
            {
                $patch = $TextBoxp1.text
                $tbox2 = $TextBoxp2.lines
                $patchcode2 = $TextBoxp5.Text
                $editedTextBox2 = ""
                foreach ($line in $tbox2)
                    {
                        $line2 = "* " + $line +"`r`n"
                        $editedTextBox2 += $line2
                    }

                $changes2 = $editedTextBox2
$additionsn = @"
|-
| Older Versions
|
{| class="mw-collapsible mw-collapsed" cellspacing="0" 
!
!
|-
|style="border-bottom: 1px solid #a2a9b1;"|$patch||style="border-bottom: 1px solid #a2a9b1;"|
$changes2
"@
                $global:state = "noneed"
                #$patchcode3 = $patchcode2.Replace("|}", $additionsn + "`r`n"+"|}" + "`r`n"+"|}")
                $patchcode3 = $patchcode2.Replace("|}", $additionsn + "|}" + "`r`n"+"|}")
                $TextBoxp5.Text = ""
                $TextBoxp5.Text += $patchcode3
                $TextBoxp1.Text = ""
                $TextBoxp2.Text = ""
                $global:state = "noneed"
            }
        }
    })

## @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## This is the end of theactual "meat" of the script, the rest is all GUI

## GUI parts
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("PresentationFramework")
[void] [Reflection.Assembly]::LoadWithPartialName("PresentationCore")

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "The lazy Qord"
$Form.Size = New-Object System.Drawing.Size(541,590)
$Form.StartPosition = "CenterScreen"
$Form.ShowInTaskbar = $True
$Form.KeyPreview = $True
$Form.AutoSize = $True
$Form.FormBorderStyle = 'Fixed3D'
$Form.MaximizeBox = $False
$Form.MinimizeBox = $False
$Form.ControlBox = $True
$Form.Icon = $Icon
$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
 
$FormTabControl = New-object System.Windows.Forms.TabControl
$FormTabControl.Size = "541,590"
$FormTabControl.Location = "0,0"
$FormTabControl.Font = [System.Drawing.Font]::new("Arial", 13, [System.Drawing.FontStyle]::Regular)

## Tab1 - Skill description tab and its elements 
$Tab1 = New-object System.Windows.Forms.Tabpage
$Tab1.DataBindings.DefaultDataSourceUpdateMode = 0
$Tab1.UseVisualStyleBackColor = $True
$Tab1.Name = "TAB1"
$Tab1.Text = "Description"
$Tab1.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Regular)
 
$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $false
$TextBox1.text                   = ""
$TextBox1.width                  = 200
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(15,81)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.text                   = ""
$TextBox2.width                  = 200
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(14,147)
$TextBox2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox3                        = New-Object system.Windows.Forms.TextBox
$TextBox3.multiline              = $false
$TextBox3.text                   = ""
$TextBox3.width                  = 200
$TextBox3.height                 = 20
$TextBox3.location               = New-Object System.Drawing.Point(12,218)
$TextBox3.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox4                        = New-Object system.Windows.Forms.TextBox
$TextBox4.multiline              = $true
$TextBox4.text                   = "None"
$TextBox4.width                  = 200
$TextBox4.height                 = 40
$TextBox4.location               = New-Object System.Drawing.Point(12,295)
$TextBox4.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox5                        = New-Object system.Windows.Forms.RichTextBox
$TextBox5.multiline              = $true
$TextBox5.width                  = 258
$TextBox5.height                 = 400
$TextBox5.location               = New-Object System.Drawing.Point(251,80)
$TextBox5.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Generated code can be copied from below"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(249,43)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "The existing skill description"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(20,123)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "What level is required"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(18,194)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "List of prerequisites"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(18,271)
$Label4.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "URL for skill icon"
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(20,58)
$Label5.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Generate Description"
$Button1.width                   = 152
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(21,363)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button1.add_Click($handler_button_Click)

 
## Tab2 - Patch changes tab and its elements 
$Tab2 = New-object System.Windows.Forms.Tabpage
$Tab2.DataBindings.DefaultDataSourceUpdateMode = 0
$Tab2.UseVisualStyleBackColor = $True
$Tab2.Name = "TAB2"
$Tab2.Text = "Patch notes"
$Tab2.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Regular)
 
$TextBoxp1                        = New-Object system.Windows.Forms.TextBox
$TextBoxp1.multiline              = $false
$TextBoxp1.text                   = ""
$TextBoxp1.width                  = 200
$TextBoxp1.height                 = 20
$TextBoxp1.location               = New-Object System.Drawing.Point(15,81)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBoxp2                        = New-Object system.Windows.Forms.TextBox
$TextBoxp2.multiline              = $true
$TextBoxp2.text                   = ""
$TextBoxp2.width                  = 200
$TextBoxp2.height                 = 100
$TextBoxp2.location               = New-Object System.Drawing.Point(14,147)
$TextBoxp2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBoxp5                        = New-Object system.Windows.Forms.RichTextBox
$TextBoxp5.multiline              = $true
$TextBoxp5.width                  = 258
$TextBoxp5.height                 = 400
$TextBoxp5.location               = New-Object System.Drawing.Point(251,80)
$TextBox5.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Labelp1                          = New-Object system.Windows.Forms.Label
$Labelp1.text                     = "URL for Patch"
$Labelp1.AutoSize                 = $true
$Labelp1.width                    = 25
$Labelp1.height                   = 10
$Labelp1.location                 = New-Object System.Drawing.Point(20,58)
$Labelp1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Labelp2                          = New-Object system.Windows.Forms.Label
$Labelp2.text                     = "Existing patch notes"
$Labelp2.AutoSize                 = $true
$Labelp2.width                    = 25
$Labelp2.height                   = 10
$Labelp2.location                 = New-Object System.Drawing.Point(20,123)
$Labelp2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Buttonp1                         = New-Object system.Windows.Forms.Button
$Buttonp1.text                    = "Generate Code"
$Buttonp1.width                   = 152
$Buttonp1.height                  = 30
$Buttonp1.location                = New-Object System.Drawing.Point(21,363)
$Buttonp1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Buttonp1.add_Click($handler_button_Clickp1)

$Buttonp2                         = New-Object system.Windows.Forms.Button
$Buttonp2.text                    = "Add more patch notes"
$Buttonp2.width                   = 152
$Buttonp2.height                  = 30
$Buttonp2.location                = New-Object System.Drawing.Point(20,447)
$Buttonp2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Buttonp2.add_Click($handler_button_Clickp2)

$Labelp5                          = New-Object system.Windows.Forms.Label
$Labelp5.text                     = "Generated code can be copied from below"
$Labelp5.AutoSize                 = $true
$Labelp5.width                    = 25
$Labelp5.height                   = 10
$Labelp5.location                 = New-Object System.Drawing.Point(249,43)
$Labelp5.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
 
## Tab switching

## Tab1 - Button1 - Close
$t1_button_click1 = {  
 
 [System.Windows.Forms.MessageBox]::Show("Tab 1")
 
}
## Tab2 - Button1 - Close
$t2_button_click1 = {  
 
 [System.Windows.Forms.MessageBox]::Show("Tab 2")
 
}
 
## Add tab controls
 
$Form.Controls.Add($FormTabControl)
$FormTabControl.Controls.Add($Tab1)
$FormTabControl.Controls.Add($Tab2)
 
$Tab1.Controls.Add($TextBox1)
$Tab1.Controls.Add($TextBox2)
$Tab1.Controls.Add($TextBox3)
$Tab1.Controls.Add($TextBox4)
$Tab1.Controls.Add($TextBox5)
$Tab1.Controls.Add($Label1)
$Tab1.Controls.Add($Label2)
$Tab1.Controls.Add($Label3)
$Tab1.Controls.Add($Label4)
$Tab1.Controls.Add($Label5)
$Tab1.Controls.Add($Button1)

$Tab2.Controls.Addrange(@($TextBoxp1,$TextBoxp2,$TextBoxp5,$Labelp1,$Labelp2,$Labelp5,$Buttonp1,$Buttonp2))

## Hide the console window, show the gui
Hide-Console
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()

