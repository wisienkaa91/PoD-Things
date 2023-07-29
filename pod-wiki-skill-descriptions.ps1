<# 
.NAME
    Qord's little helper, skill intro/description edition
.DESCRIPTION
    Utility to create copyable code for skill descriptions
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
        If no prereqs you can ignor this line
    Enter the level required
    Click the button to generate code
    Copy it from the textbox on the right and paste it into the wiki for the relevant skill, 
        replacing the existing 3 lines mentioned above
#>
function OnApplicationLoad {
return $true 
}

function OnApplicationExit {
$script:ExitCode = 0 
}

$handler_button_Click={
$TextBox5.Text = ""
$url = $TextBox1.text
$description = $TextBox2.text
$lvlreq = $TextBox3.text
$prereqs = $TextBox4.text

$skillcode = @"
{|
| colspan="2" |
{|
|rowspan="3" style="vertical-align:top; padding:0.5em 0.5em 0.5em 0.5em; width:5%"|$url ||'''Description:''' $description'''
|-
|'''Required Level:''' $lvlreq
|-
|'''Prerequisites:''' $prereqs
|}
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
 $TextBox4.text = "None"
}

function GenerateForm {
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

    $Form                            = New-Object system.Windows.Forms.Form
    $Form.ClientSize                 = New-Object System.Drawing.Point(541,590)
    $Form.text                       = "PoD Lazy Copy/Paster Tool for Skill Descriptions"
    $Form.TopMost                    = $false

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
    $TextBox4.multiline              = $false
    $TextBox4.text                   = "None"
    $TextBox4.width                  = 200
    $TextBox4.height                 = 20
    $TextBox4.location               = New-Object System.Drawing.Point(12,295)
    $TextBox4.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $Label5                          = New-Object system.Windows.Forms.Label
    $Label5.text                     = "URL for skill icon"
    $Label5.AutoSize                 = $true
    $Label5.width                    = 25
    $Label5.height                   = 10
    $Label5.location                 = New-Object System.Drawing.Point(20,58)
    $Label5.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

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

    $ToolTip1                        = New-Object system.Windows.Forms.ToolTip
    $ToolTip1.ToolTipTitle           = "Copying and pasting the existing skill description and list of requisite skills is reccommended"

    $Button1                         = New-Object system.Windows.Forms.Button
    $Button1.text                    = "Generate Code"
    $Button1.width                   = 152
    $Button1.height                  = 30
    $Button1.location                = New-Object System.Drawing.Point(21,363)
    $Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $Button1.add_Click($handler_button_Click)
    
    $Label1                          = New-Object system.Windows.Forms.Label
    $Label1.text                     = "Generated code can be copied from below"
    $Label1.AutoSize                 = $true
    $Label1.width                    = 25
    $Label1.height                   = 10
    $Label1.location                 = New-Object System.Drawing.Point(249,43)
    $Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    
    $TextBox5                        = New-Object system.Windows.Forms.RichTextBox
    $TextBox5.multiline              = $true
    $TextBox5.width                  = 258
    $TextBox5.height                 = 400
    $TextBox5.location               = New-Object System.Drawing.Point(251,80)
    $TextBox5.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    
    $Form.controls.AddRange(@($TextBox1,$TextBox2,$TextBox3,$TextBox4,$Label5,$Label2,$Label3,$Label4,$Button1,$Label1,$TextBox5))

    [void]$Form.ShowDialog()
    $InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
    $formEvent_Load={
    }
}

if(OnApplicationLoad -eq $true)
{
GenerateForm | Out-Null
OnApplicationExit
}
