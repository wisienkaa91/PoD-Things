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
    v2.3
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
$iconurl = $TextBox1.text
$description = $TextBox2.text
$lvlreq = $TextBox3.text
$prereqs = $TextBox4.text
$skillcode = "{{Skilldesc|$iconurl|$description|$lvlreq|$prereqs}}"
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

## @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## Tab 2 Functions

$handler_button_Clickp1={
    $global:state = "need"
    $TextBoxp5.Text = ""
    $tbox2 = $TextBoxp2.lines
    foreach ($line in $tbox2)
        {
            $line2 = "* " + $line +"`r`n"
            $editedTextBox2 += $line2
        }
    $x = $listBox.SelectedItem
    switch -wildcard ($x)
        {
          '*Bedrock*' {$url = "[[Patch_Notes#Patch_.231:_Bedrock|#1 Bedrock]]"}
          '*Quartz*' {$url = "[[Patch_Notes#Patch_.232:_Quartz|#2 Quartz]]"}
          '*Granite*' {$url = "[[Patch_Notes#Patch_.233:_Granite|#3 Granite]]"}
          '*Onyx*' {$url = "[[Patch_Notes#Patch_.234:_Onyx|#4 Onyx]]"}
          '*Limestone*' {$url = "[[Patch_Notes#Patch_.235:_Limestone|#5 Limestone]]"}
          '*Obsidian*' {$url = "[[Patch_Notes#Patch_.236:_Obsidian|#6 Obsidian]]"}
          '*Beryl*' {$url = "[[Patch_Notes#Patch_.237:_Beryl|#7 Beryl]]"}
          '*Pyrite*' {$url = "[[Patch_Notes#Patch_.238:_Pyrite|#8 Pyrite]]"}
          '*Aventurine*' {$url = "[[Patch_Notes#Patch_.239:_Aventurine|#9 Aventurine]]"}
          '*Tanzanite*' {$url = "[[Patch_Notes#Patch_.2310:_Tanzanite|#10 Tanzanite]]"}
          '*Kyanite*' {$url = "[[Patch_Notes#Patch_.2311:_Kyanite|#11 Kyanite]]"}
          '*Edenite*' {$url = "[[Patch_Notes#Patch_.2312:_Edenite|#12 Edenite]]"}
          '*Titanium*' {$url = "[[Patch_Notes#Patch_.2313:_Titanium|#13 Titanium]]"}
          '*Serandite*' {$url = "[[Patch_Notes#Patch_.2314:_Serandite|#14 Serandite]]"}
          '*Graphite*' {$url = "[[Patch_Notes#Patch_.2315:_Graphite|#15 Graphite]]"}
          '*Jade*' {$url = "[[Patch_Notes#Patch_.2316:_Jade|#16 Jade]]"}
          '*Tourmaline*' {$url = "[[Patch_Notes#Patch_.2317:_Tourmaline|#17 Tourmaline]]"}
          '*Flint*' {$url = "[[Patch_Notes#Patch_.2318:_Flint|#18 Flint]]"}
          '*Zincite*' {$url = "[[Patch_Notes#Patch_.2319:_Zincite|#19 Zincite]]"}
          '*Perlite*' {$url = "[[Patch_Notes#Patch_.2320:_Perlite|#20 Perlite]]"}
          '*Shugnite*' {$url = "[[Patch_Notes#Patch_.2321:_Shungite|#21 Shungite]]"}
        }
$patch = $url
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
    $x = $listBox.SelectedItem
    switch -wildcard ($x)
        {
          '*Bedrock*' {$url = "[[Patch_Notes#Patch_.231:_Bedrock|#1 Bedrock]]"}
          '*Quartz*' {$url = "[[Patch_Notes#Patch_.232:_Quartz|#2 Quartz]]"}
          '*Granite*' {$url = "[[Patch_Notes#Patch_.233:_Granite|#3 Granite]]"}
          '*Onyx*' {$url = "[[Patch_Notes#Patch_.234:_Onyx|#4 Onyx]]"}
          '*Limestone*' {$url = "[[Patch_Notes#Patch_.235:_Limestone|#5 Limestone]]"}
          '*Obsidian*' {$url = "[[Patch_Notes#Patch_.236:_Obsidian|#6 Obsidian]]"}
          '*Beryl*' {$url = "[[Patch_Notes#Patch_.237:_Beryl|#7 Beryl]]"}
          '*Pyrite*' {$url = "[[Patch_Notes#Patch_.238:_Pyrite|#8 Pyrite]]"}
          '*Aventurine*' {$url = "[[Patch_Notes#Patch_.239:_Aventurine|#9 Aventurine]]"}
          '*Tanzanite*' {$url = "[[Patch_Notes#Patch_.2310:_Tanzanite|#10 Tanzanite]]"}
          '*Kyanite*' {$url = "[[Patch_Notes#Patch_.2311:_Kyanite|#11 Kyanite]]"}
          '*Edenite*' {$url = "[[Patch_Notes#Patch_.2312:_Edenite|#12 Edenite]]"}
          '*Titanium*' {$url = "[[Patch_Notes#Patch_.2313:_Titanium|#13 Titanium]]"}
          '*Serandite*' {$url = "[[Patch_Notes#Patch_.2314:_Serandite|#14 Serandite]]"}
          '*Graphite*' {$url = "[[Patch_Notes#Patch_.2315:_Graphite|#15 Graphite]]"}
          '*Jade*' {$url = "[[Patch_Notes#Patch_.2316:_Jade|#16 Jade]]"}
          '*Tourmaline*' {$url = "[[Patch_Notes#Patch_.2317:_Tourmaline|#17 Tourmaline]]"}
          '*Flint*' {$url = "[[Patch_Notes#Patch_.2318:_Flint|#18 Flint]]"}
          '*Zincite*' {$url = "[[Patch_Notes#Patch_.2319:_Zincite|#19 Zincite]]"}
          '*Perlite*' {$url = "[[Patch_Notes#Patch_.2320:_Perlite|#20 Perlite]]"}
          '*Shugnite*' {$url = "[[Patch_Notes#Patch_.2321:_Shungite|#21 Shungite]]"}
        }
$patch = $url
    Switch ($global:state) {
        "evenmore"
            {
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
                $patchcode3 = $TextBoxp5Text.Replace("|}", $additionsnn + "|}" + "`r`n"+"|}")
                $TextBoxp5.Text = ""
                $TextBoxp5.Text += $patchcode3
                $TextBoxp1.Text = ""
                $TextBoxp2.Text = ""
                $global:state = "evenmore"
            }

        "need"
            {
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
## Tab 3 Functions

$handler_button_Clickpre1=({
$TextBoxpre1.Text = ""
$prerqcode = "{{Skilldescnosynergiesleft}}"
$TextBoxpre1.Text += $prerqcode
})

$handler_button_Clickpre2=({
$TextBoxpre1.Text = ""
$prerqcode = "{{Skilldescnosynergiesright}}"
$TextBoxpre1.Text += $prerqcode
})

$handler_button_Clickpre3=({


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

#########
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

######### 
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
$TextBoxp2.location               = New-Object System.Drawing.Point(15,200)
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

$listBox                          = New-Object System.Windows.Forms.ListBox
$listBox.Location                 = New-Object System.Drawing.Point(15,80)
$listBox.Size                     = New-Object System.Drawing.Size(200,20)
$listBox.Height                   = 80
[void] $listBox.Items.Add(' #1 Bedrock ')
[void] $listBox.Items.Add(' #2 Quartz ')
[void] $listBox.Items.Add(' #3 Granite ')
[void] $listBox.Items.Add(' #4 Onyx ')
[void] $listBox.Items.Add(' #5 Limestone ')
[void] $listBox.Items.Add(' #6 Obsidian ')
[void] $listBox.Items.Add(' #7 Beryl ')
[void] $listBox.Items.Add(' #8 Pyrite ')
[void] $listBox.Items.Add(' #9 Aventurine ')
[void] $listBox.Items.Add(' #10 Tanzanite ')
[void] $listBox.Items.Add(' #11 Kyanite ')
[void] $listBox.Items.Add(' #12 Edenite ')
[void] $listBox.Items.Add(' #13 Titanium ')
[void] $listBox.Items.Add(' #14 Serandite ')
[void] $listBox.Items.Add(' #15 Graphite ')
[void] $listBox.Items.Add(' #16 Jade ')
[void] $listBox.Items.Add(' #17 Tourmaline ')
[void] $listBox.Items.Add(' #18 Flint ')
[void] $listBox.Items.Add(' #19 Zincite ')
[void] $listBox.Items.Add(' #20 Perlite ')
[void] $listBox.Items.Add(' #21 Shugnite ')


$Labelp2                          = New-Object system.Windows.Forms.Label
$Labelp2.text                     = "Existing patch notes"
$Labelp2.AutoSize                 = $true
$Labelp2.width                    = 25
$Labelp2.height                   = 10
$Labelp2.location                 = New-Object System.Drawing.Point(20,175)
$Labelp2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Buttonp1                         = New-Object system.Windows.Forms.Button
$Buttonp1.text                    = "Generate Patch Notes"
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

#########
## Tab3 - Empty prereq's left and right
$Tab3 = New-object System.Windows.Forms.Tabpage
$Tab3.DataBindings.DefaultDataSourceUpdateMode = 0
$Tab3.UseVisualStyleBackColor = $True
$Tab3.Name = "TAB3"
$Tab3.Text = "Synergies"
$Tab3.Font = [System.Drawing.Font]::new("Arial", 9, [System.Drawing.FontStyle]::Regular)

$TextBoxpre1                        = New-Object system.Windows.Forms.RichTextBox
$TextBoxpre1.multiline              = $true
$TextBoxpre1.width                  = 258
$TextBoxpre1.height                 = 400
$TextBoxpre1.location               = New-Object System.Drawing.Point(251,80)
$TextBoxpre1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBoxpre2                        = New-Object system.Windows.Forms.RichTextBox
$TextBoxpre2.multiline              = $true
$TextBoxpre2.width                  = 200
$TextBoxpre2.height                 = 30
$TextBoxpre2.location               = New-Object System.Drawing.Point(20,80)
$TextBoxpre2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBoxpre3                        = New-Object system.Windows.Forms.RichTextBox
$TextBoxpre3.multiline              = $true
$TextBoxpre3.width                  = 200
$TextBoxpre3.height                 = 30
$TextBoxpre3.location               = New-Object System.Drawing.Point(20,153)
$TextBoxpre3.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)


$Labelpre1                          = New-Object system.Windows.Forms.Label
$Labelpre1.text                     = "Generated code can be copied from below"
$Labelpre1.AutoSize                 = $true
$Labelpre1.width                    = 25
$Labelpre1.height                   = 10
$Labelpre1.location                 = New-Object System.Drawing.Point(249,43)
$Labelpre1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Labelpre2                          = New-Object system.Windows.Forms.Label
$Labelpre2.text                     = "URL Synergy"
$Labelpre2.AutoSize                 = $true
$Labelpre2.width                    = 25
$Labelpre2.height                   = 10
$Labelpre2.location                 = New-Object System.Drawing.Point(20,58)
$Labelpre2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Labelpre3                          = New-Object system.Windows.Forms.Label
$Labelpre3.text                     = "Synergy Effect"
$Labelpre3.AutoSize                 = $true
$Labelpre3.width                    = 25
$Labelpre3.height                   = 10
$Labelpre3.location                 = New-Object System.Drawing.Point(20,123)
$Labelpre3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Buttonpre1                         = New-Object system.Windows.Forms.Button
$Buttonpre1.text                    = "Empty on Left"
$Buttonpre1.width                   = 152
$Buttonpre1.height                  = 30
$Buttonpre1.location                = New-Object System.Drawing.Point(20,500)
$Buttonpre1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Buttonpre1.add_Click($handler_button_Clickpre1)

$Buttonpre2                         = New-Object system.Windows.Forms.Button
$Buttonpre2.text                    = "Empty on Right"
$Buttonpre2.width                   = 152
$Buttonpre2.height                  = 30
$Buttonpre2.location                = New-Object System.Drawing.Point(250,500)
$Buttonpre2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Buttonpre2.add_Click($handler_button_Clickpre2)

$Buttonpre3                         = New-Object system.Windows.Forms.Button
$Buttonpre3.text                    = "Add Synergy"
$Buttonpre3.width                   = 152
$Buttonpre3.height                  = 30
$Buttonpre3.location                = New-Object System.Drawing.Point(21,300)
$Buttonpre3.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Buttonpre3.add_Click($handler_button_Clickpre3)

$Buttonpre4                         = New-Object system.Windows.Forms.Button
$Buttonpre4.text                    = "Add More Synergy"
$Buttonpre4.width                   = 152
$Buttonpre4.height                  = 30
$Buttonpre4.location                = New-Object System.Drawing.Point(21,363)
$Buttonpre4.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Buttonpre4.add_Click($handler_button_Clickpre4)
 
## Tab switching

## Tab1 - Button1 - Close
$t1_button_click1 = {  
 
 [System.Windows.Forms.MessageBox]::Show("Tab 1")
 
}
## Tab2 - Button1 - Close
$t2_button_click1 = {  
 
 [System.Windows.Forms.MessageBox]::Show("Tab 2")
 
}
 
## Tab3 - Button1 - Close
$t3_button_click1 = {  
 
 [System.Windows.Forms.MessageBox]::Show("Tab 3")
 
} 
## Add tab controls
 
$Form.Controls.Add($FormTabControl)
$FormTabControl.Controls.Add($Tab1)
#$FormTabControl.Controls.Add($Tab3)
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

#$Tab2.Controls.Addrange(@($TextBoxp1,$TextBoxp2,$TextBoxp5,$Labelp1,$Labelp2,$Labelp5,$Buttonp1,$Buttonp2))
$Tab2.Controls.Addrange(@($ListBox,$TextBoxp2,$TextBoxp5,$Labelp1,$Labelp2,$Labelp5,$Buttonp1,$Buttonp2))

$Tab3.Controls.Addrange(@($TextBoxpre1,$TextBoxpre2,$TextBoxpre3,$Labelpre1,$Labelpre2,$Labelpre3,$Buttonpre1,$Buttonpre2,$Buttonpre3,$Buttonpre4))

## Hide the console window, show the gui
Hide-Console
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()

