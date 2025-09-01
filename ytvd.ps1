#
$pwshPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$script:debug = $false
$script:multiple_audio = $false
$IsRemoteInvocation = $true
if ($PSScriptRoot -eq "") {$IsRemoteInvocation = $true}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Создаем форму
$form = New-Object System.Windows.Forms.Form
$form.Text = "Video Download"
$form.Size = New-Object System.Drawing.Size(500,95)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedSingle' #
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.BackColor = [System.Drawing.Color]::FromArgb(1,46,110)
$form.ForeColor = [System.Drawing.Color]::White

# Создаем текстовое поле
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(20,20)
$textBox.Size = New-Object System.Drawing.Size(292,25)
$form.Controls.Add($textBox)
$form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($pwshPath)

# Создаем кнопку Paste
$button_paste = New-Object System.Windows.Forms.Button
$button_paste.Location = New-Object System.Drawing.Point(310,20)
$button_paste.Size = New-Object System.Drawing.Size(50,20)
$button_paste.Text = "Paste"
$form.Controls.Add($button_paste)

# Создаем кнопку Reset
$button_reset = New-Object System.Windows.Forms.Button
$button_reset.Location = New-Object System.Drawing.Point(310,20)
$button_reset.Size = New-Object System.Drawing.Size(50,20)
$button_reset.Text = "Reset"
$button_reset.Visible = 0
$form.Controls.Add($button_reset)

# Создаем кнопку Debug
$button_debug = New-Object System.Windows.Forms.Button
$button_debug.Location = New-Object System.Drawing.Point(0,0)
$button_debug.Size = New-Object System.Drawing.Size(50,20)
$button_debug.Text = "Debug"
$button_debug.Visible = $false
$form.Controls.Add($button_debug)

# Создаем кнопку Search
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(370,14)
$button.Size = New-Object System.Drawing.Size(100,30)
$button.Text = "Search"
$form.Controls.Add($button)

# Создаем кнопку Download
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(370,14)
$button1.Size = New-Object System.Drawing.Size(100,30)
$button1.Text = "Download"
$button1.Visible = 0
$form.Controls.Add($button1)

# Создаем первый ComboBox для Quality
$comboRes = New-Object System.Windows.Forms.ComboBox
$comboRes.Location = New-Object System.Drawing.Point(20,70)
$comboRes.Size = New-Object System.Drawing.Size(120,25)
$comboRes.DropDownStyle = 'DropDownList'  # чтобы нельзя было вводить текст
$comboRes.Visible = 0 #
$form.Controls.Add($comboRes)

# Создаем второй ComboBox для TBR
$comboTBR = New-Object System.Windows.Forms.ComboBox
$comboTBR.Location = New-Object System.Drawing.Point(160,70)
$comboTBR.Size = New-Object System.Drawing.Size(120,25)
$comboTBR.DropDownStyle = 'DropDownList'
$comboTBR.Visible = 0 #
$form.Controls.Add($comboTBR)

# Создаем первый ComboBox для Language
$comboLang = New-Object System.Windows.Forms.ComboBox
$comboLang.Location = New-Object System.Drawing.Point(20,115)
$comboLang.Size = New-Object System.Drawing.Size(120,25)
$comboLang.DropDownStyle = 'DropDownList'
$comboLang.Visible = 0 #
$form.Controls.Add($comboLang)

# Создаем Label1
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(59,50)
$label1.Size = New-Object System.Drawing.Size(60,25)
$label1.Text = "Quality:"
$label1.Visible = 0 #
$label1.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Regular)
$form.Controls.Add($label1)

# Создаем Label2
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(185,50)
$label2.Size = New-Object System.Drawing.Size(80,25)
$label2.Text = "Total BitRate:"
$label2.Visible = 0 #
$label2.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Regular)
$form.Controls.Add($label2)

# Создаем Label3
$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(316,50)
$label3.Size = New-Object System.Drawing.Size(40,20)
$label3.Text = "Size:"
$label3.Visible = 0 #
$label3.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Regular)
$form.Controls.Add($label3)

# Создаем Label4
$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(390,50)
$label4.Size = New-Object System.Drawing.Size(80,20)
$label4.Text = "Resolution:"
$label4.Visible = 0 #
$label4.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Regular)
$form.Controls.Add($label4)

# Создаем Label5
$label5 = New-Object System.Windows.Forms.Label
$label5.Location = New-Object System.Drawing.Point(291,70)
$label5.Size = New-Object System.Drawing.Size(80,25)
$label5.Text = "None"
$label5.TextAlign = 'MiddleCenter'
$label5.Visible = 0 #
$label5.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Regular)
$form.Controls.Add($label5)

# Создаем Label6
$label6 = New-Object System.Windows.Forms.Label
$label6.Location = New-Object System.Drawing.Point(380,70)
$label6.Size = New-Object System.Drawing.Size(80,25)
$label6.Text = "None"
$label6.TextAlign = 'MiddleCenter'
$label6.Visible = 0 #
$label6.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Regular)
$form.Controls.Add($label6)

# Создаем Label7
$label7 = New-Object System.Windows.Forms.Label
$label7.Location = New-Object System.Drawing.Point(53,95)
$label7.Size = New-Object System.Drawing.Size(60,25)
$label7.Text = "Language:"
$label7.Visible = 0 #
$label7.Font = New-Object System.Drawing.Font("Arial",8,[System.Drawing.FontStyle]::Regular)
$form.Controls.Add($label7)

#Проверка ссылки на TikTok
function Test-TikTokUrl {
    param (
        [string]$Url
    )
    
    # Приводим URL к нижнему регистру для удобства проверки
    $Url = $Url.ToLower()
    
    # Основные шаблоны доменов TikTok
    $TikTokDomains = @(
        'tiktok.com',
        'vm.tiktok.com',
        'vt.tiktok.com',
        'www.tiktok.com',
        'm.tiktok.com'
        # Можно добавить другие, если они появятся
    )
    
    # Проверяем, содержит ли URL один из доменов TikTok
    foreach ($Domain in $TikTokDomains) {
        if ($Url -match [regex]::Escape($Domain)) {
            return $true
        }
    }
    
    return $false
}

#Выбор папки
function Folder-choose {

    param (
        [string]$text = ""
    )
    Add-Type -AssemblyName System.Windows.Forms
    
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = $text
    $folderBrowser.ShowNewFolderButton = $false

    if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $script:selectedPath = $folderBrowser.SelectedPath
        return $script:selectedPath
    } else {
       if ($default -eq $true){return $downloadsPath} else {exit}
    }
}

#Проверка наличия yt-dlp.exe
function yt-dlp_test {
    try {
        # Попытка запустить yt-dlp
        & "yt-dlp.exe" "--version" *>$null
    }
    catch {
        # Если произошла ошибка
        $script:yt_dlp_error = $true
        [System.Windows.Forms.MessageBox]::Show(
        "Choose filepath to yt-dlp.exe",
        "yt-dlp.exe not found",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
        )
        Folder-choose -text "Select a folder with yt-dlp.exe"
        $script:yt_dlp_path = $script:selectedPath + "\yt-dlp.exe"
        $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
        $newPath = $userPath + ";" + $script:selectedPath
        [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    }
}

#Проверка наличия ffpmeg.exe
function FFmpeg_test {
    try {
        # Попытка запустить ffmpeg
        & "ffmpeg.exe" *>$null
    }
    catch {
        # Если произошла ошибка
        $script:ffmpeg_error = $true
        [System.Windows.Forms.MessageBox]::Show(
        "Choose filepath to ffmpeg.exe",
        "ffmpeg.exe not found",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
        )
        Folder-choose -text "Select a folder with ffmpeg.exe"
        $script:ffmpeg_path = $script:selectedPath  + "\ffmpeg.exe"
        $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
        $newPath = $userPath + ";" + $script:selectedPath
        [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    }
}

#Функция для преобразования размера в читаемый формат
function Format-FileSize {
    param([int64]$Size)
    if ($Size -eq 0) { return "0 B" }
    $units = @("B", "KB", "MB", "GB", "TB")
    $i = 0
    $sizeDecimal = [decimal]$Size  # Преобразуем в decimal для точности
    
    while ($sizeDecimal -ge 1024 -and $i -lt $units.Length - 1) {
        $sizeDecimal = $sizeDecimal / 1024
        $i++
    }
    
    # Округляем до двух знаков после запятой
    return "{0:N2} {1}" -f $sizeDecimal, $units[$i]
}

#Событие нажатия на кнопку Paste
$button_paste.Add_Click({
    $textBox.Text = [System.Windows.Forms.Clipboard]::GetText()
})            #### готово

#Событие нажатия на кнопку Reset
$button_reset.Add_Click({
    $textBox.Text = ""
    $button.Visible = 1
    $button1.Visible = 0
    $button_reset.Visible = 0
    $button_paste.Visible = 1
    $button_debug.Visible = $false
    $form.Size = New-Object System.Drawing.Size(500,95)
    $textBox.Enabled = $true
    $comboLang.Visible = $false
    $label7.Visible = $false
    $comboRes.Visible = 0
    $comboTBR.Visible = 0
    $label1.Visible = 0
    $label2.Visible = 0
    $label3.Visible = 0
    $label4.Visible = 0
    $label5.Visible = 0
    $label6.Visible = 0
    $form.Text = "Video Download"
})            #### готово(перепроверить)

#Событие нажатия на кнопку Search
$button.Add_Click({

    $script:url = $textBox.Text
    if ($script:url -ne "") {
        $button.Text = "Searching..."
    } else {
        [System.Windows.Forms.MessageBox]::Show("URL is empry!")
        return
    }

    if (Test-Path $env:TEMP\videos.json) {
        Remove-Item -Path "$env:TEMP\videos.json"
    }

    try {
        if($script:yt_dlp_error -like $true){
            & "$script:yt_dlp_path" "--dump-single-json" $script:url >> "$env:TEMP\videos.json"
        } else {
            & "yt-dlp.exe" "--dump-single-json" $script:url >> "$env:TEMP\videos.json"
        }
        
        # Проверяем код возврата
        if ($LASTEXITCODE -ne 0) {
            throw "yt-dlp exited with code $LASTEXITCODE"
        }
    }
    catch {
        #Write-Host "Ошибка при выполнении yt-dlp: $($_.Exception.Message)" -ForegroundColor Red
        #Write-Host "Детали ошибки: $($Error[0])" -ForegroundColor Yellow
        
        $button.Text = "Search"
        [System.Windows.Forms.MessageBox]::Show(
            "Invalid URL",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        Clear-Host
        $textBox.Text = ""
        return
    }



    $button_debug.Visible = $true

    $jsonContent = Get-Content -Path "$env:TEMP\videos.json" -Raw | ConvertFrom-Json

    $script:videos = @()
    $script:audios = @()

    if (Test-TikTokUrl -Url $script:url){
        
        foreach ($format in $jsonContent.formats) {
            # Видео форматы MP4
            if ($format.ext -eq "mp4" -and $format.vcodec -ne "none") {
                $videoInfo = [PSCustomObject]@{
                    ID = $format.format_id
                    Resolution = $format.resolution
                    Size = if ($format.filesize) { Format-FileSize $format.filesize } else { "Unknown" }
                    Raw_size = $format.filesize
                    TBR = if ($format.tbr) { "{0:N2} kbps" -f $format.tbr } else { "Unknown" }
                    Quality = if ($format.quality) { $format.quality } else { "0" }
                    FormatNote = $format.resolution
                    Width = $format.width
                    Height = $format.height
                }
                $script:videos += $videoInfo
            }
        } #обработка json

        ##################################################################################################### Название канала | ролика | лайков
        $encoded_title = $jsonContent.title
        $encoded_chanel = $jsonContent.channel
        $likes = $jsonContent.like_count
        Add-Type -AssemblyName System.Web
        $video_title = [System.Web.HttpUtility]::HtmlDecode($encoded_title)
        $chanel_title = [System.Web.HttpUtility]::HtmlDecode($encoded_chanel)
        $form.Text = $encoded_chanel + " | "+$video_title + " | " + $likes + " likes"
        
        Remove-Item -Path "$env:TEMP\videos.json"
        
        if ($script:debug -eq $true){ $script:videos | Format-Table | Out-Host }
        $comboRes.Items.Clear()
        #####################################################################################################

        $sortedResolutions = $script:videos | Select-Object -ExpandProperty Resolution | Sort-Object @{
            Expression = {
                # Извлекаем ширину (первое число из "1080x1920")
                if ($_ -match '(\d+)x\d+') { 
                    [int]$matches[1] 
                } else { 
                    0 
                }
            }
            Descending = $true
        } -Unique #Сортировка Resolution
        $comboRes.Items.AddRange($sortedResolutions) #Сортировка Resolution

        $form.Size = New-Object System.Drawing.Size(500,140)

        $button.Text = "Search"
        $button.Visible = 0
        $button1.Visible = 1
        $label1.Visible = 1
        $label2.Visible = 1
        $label3.Visible = 1
        $label4.Visible = 1
        $label5.Visible = 1
        $label6.Visible = 1
        $comboRes.Visible = 1
        $comboTBR.Visible = 1
        $priority = @("1080x1920", "720x1280","640x1136","576x1024","480x854","360x640")

        foreach ($res in $priority) {
            if ($comboRes.Items -contains $res) {
               $comboRes.SelectedItem = $res
                break
            }
        }

        $textBox.Enabled = $false
        $button_paste.Visible = $false
        $button_reset.Visible = $true

    } else {
        # Обрабатываем форматы
        foreach ($format in $jsonContent.formats) {
            # Видео форматы MP4
            if ($format.ext -eq "mp4" -and $format.vcodec -ne "none") {
                $videoInfo = [PSCustomObject]@{
                    ID = $format.format_id
                    Resolution = $format.resolution
                    Size = if ($format.filesize_approx) { Format-FileSize $format.filesize_approx } else { "Unknown" }
                    Raw_size = $format.filesize_approx
                    TBR = if ($format.tbr) { "{0:N2} kbps" -f $format.tbr } else { "Unknown" }
                    Quality = if ($format.quality) { $format.quality } else { "0,0" }
                    FormatNote = $format.format_note
                    Width = $format.width
                    Height = $format.height
                    FPS = $format.fps
                }
                $script:videos += $videoInfo
            }
            
            # Аудио форматы M4A
            if ($format.ext -eq "m4a" -and $format.vcodec -eq "none" -and $format.acodec -like "mp4a*") {
                $audioInfo = [PSCustomObject]@{
                    ID = $format.format_id
                    Size = if ($format.filesize_approx) { Format-FileSize $format.filesize_approx } else { "Unknown" }
                    Raw_size = $format.filesize_approx
                    TBR = if ($format.tbr) { "{0:N2} kbps" -f $format.tbr } else { "Unknown" }
                    Language = if ($format.language) { $format.language } else { "Unknown" }
                    FormatNote = $format.format_note.Split(",")[0].Trim()
                    ASR = if ($format.asr) { "{0} Hz" -f $format.asr } else { "Unknown" }
                    AudioChannels = if ($format.audio_channels) { $format.audio_channels } else { "Unknown" }
                }
                $script:audios += $audioInfo
            }
        }
    
        $encoded_title = $jsonContent.title
        $encoded_chanel = $jsonContent.channel
        $likes = $jsonContent.like_count
        Add-Type -AssemblyName System.Web
        $video_title = [System.Web.HttpUtility]::HtmlDecode($encoded_title)
        $chanel_title = [System.Web.HttpUtility]::HtmlDecode($encoded_chanel)
        $form.Text = $encoded_chanel + " | "+$video_title + " | " + $likes + " likes"
        
        Remove-Item -Path "$env:TEMP\videos.json"
    
        if ($script:debug -eq $true){
        $script:audios | Format-Table | Out-Host
        $script:videos | Format-Table | Out-Host
        }
    
        $comboRes.Items.Clear()
        $comboTBR.Items.Clear()
        
        $sortedResolutions = $script:videos | Select-Object -ExpandProperty FormatNote | Sort-Object @{
            Expression = {
                # Извлекаем числовое значение разрешения
                if ($_ -match '(\d+)p') { [int]$matches[1] } else { 0 }
            }
            Descending = $true
        }, @{
            Expression = {
                # Сортируем по наличию HDR и 60fps
                if ($_ -match 'HDR') { 2 } 
                elseif ($_ -match '60') { 1 }
                else { 0 }
            }
            Descending = $true
        } -Unique
        
        $comboRes.Items.AddRange($sortedResolutions)
    
        if ($script:audios | Where-Object { $_.id -eq "140-0" }) {
            $script:multiple_audio = $true
            $form.Size = New-Object System.Drawing.Size(500,185)
            $comboLang.Visible = $true
            $label7.Visible = $true
            $comboLang.Items.AddRange(($script:audios | Select-Object -ExpandProperty FormatNote | Sort-Object -Unique -Descending))
            $priority = "original"
            foreach ($res in $priority) {
                # Ищем строки, которые содержат слово "original" как отдельное слово
                $match = $comboLang.Items | Where-Object { 
                    $_ -match "\b$res\b" -or 
                    $_ -like "*$res*" -and $_ -notmatch "[a-zA-Z]$res" -and $_ -notmatch "$res[a-zA-Z]"
                }
                
                if ($match) {
                    $comboLang.SelectedItem = $match
                    break
                }
            }
    } else { $form.Size = New-Object System.Drawing.Size(500,140) } #Несколько звуков


    $button.Text = "Search"
    $button.Visible = 0
    $button1.Visible = 1
    $label1.Visible = 1
    $label2.Visible = 1
    $label3.Visible = 1
    $label4.Visible = 1
    $label5.Visible = 1
    $label6.Visible = 1
    $comboRes.Visible = 1
    $comboTBR.Visible = 1
    $priority = @("1080p60","1080p","720p60","720p","480p","360p","240p","144p")

    foreach ($res in $priority) {
        if ($comboRes.Items -contains $res) {
           $comboRes.SelectedItem = $res
            break
        }
    }

    $textBox.Enabled = $false
    $button_paste.Visible = $false
    $button_reset.Visible = $true
    }
})                  #### готово

#Событие нажатия на кнопку Download
$button1.Add_Click({

    if ($IsRemoteInvocation = $true) {
        Folder-choose -text "Select video download location"
    }

    if (Test-TikTokUrl -Url $script:url){
        $selectedRes = $comboRes.SelectedItem
        $id = $script:videos | Where-Object { ($_.Resolution.ToString().Trim()) -ieq $selectedRes.ToString().Trim() } |Select-Object -ExpandProperty ID | Sort-Object -Unique -Descending
        $button1.Text = "Downloading..."
        $button_reset.Enabled = $false 
        $button_debug.Visible = $false


        $proc = New-Object System.Diagnostics.Process
        if ($script:yt_dlp_error -like $true) {$proc.StartInfo.FileName = "$script:yt_dlp_path"} else {$proc.StartInfo.FileName = "yt-dlp.exe"}
        if ($IsRemoteInvocation = $true) {
            if ($script:yt_dlp_error -like $true) {$proc.StartInfo.Arguments = "--ffmpeg-location $script:ffmpeg_path -P $script:selectedPath -f $id $script:url"} else {$proc.StartInfo.Arguments = "-P $script:selectedPath -f $id $script:url"}
        } else {
            if ($script:yt_dlp_error -like $true) {$proc.StartInfo.Arguments = "--ffmpeg-location $script:ffmpeg_path -f $id $script:url"} else {$proc.StartInfo.Arguments = "-f $id $script:url"}
        }
        $proc.StartInfo.UseShellExecute = $false
        $proc.StartInfo.RedirectStandardOutput = $true
        $proc.StartInfo.RedirectStandardError = $true
        $proc.StartInfo.CreateNoWindow = $true

        $proc.Start() | Out-Null

        Clear-Host
        # Чтение в реальном времени, без блокировки
        while (-not $proc.HasExited -or -not $proc.StandardOutput.EndOfStream) {
            if (-not $proc.StandardOutput.EndOfStream) {
                $line = $proc.StandardOutput.ReadLine()
    
                if ($line) {
                    # Проверка на ключевые слова
                if ($line -match "Destination" -or $line -match "\[Merger\]" -or $line -match "Deleting" -or $line -match "has already been downloaded") {
                        # Конвертация строки в CP1251
                    $bytes = [System.Text.Encoding]::GetEncoding(866).GetBytes($line)
                    $lineCP1251 = [System.Text.Encoding]::GetEncoding(1251).GetString($bytes)
                    Write-Host $lineCP1251
                } else {
                    # Просто вывод остальных строк
                    Write-Host $line
                }
                }
            } else {
                Start-Sleep -Milliseconds 50
            }
        }

        $proc.WaitForExit()
        Write-Host "Downloaded!"
        $button1.Text = "Download"
        Clear-Host
        
        [System.Media.SystemSounds]::Exclamation.Play()

        $button.Visible = 1
        $button1.Visible = 0
        $button_reset.Enabled = $true
        $button_debug.Visible = $false
        $comboRes.Visible = 0
        $label1.Visible = 0
        $label2.Visible = 0
        $label3.Visible = 0
        $label4.Visible = 0
        $label5.Visible = 0
        $label6.Visible = 0
        $textBox.Enabled = $true
        $button_paste.Visible = 1
        $button_reset.Visible = 0
        $form.Text = "Video download"
        $textBox.Text = ""
    
        $form.Size = New-Object System.Drawing.Size(500,95)

    } else {
        $selectedRes = $comboRes.SelectedItem
        $selectedTBR = $comboTBR.SelectedItem
        $id = $script:videos | Where-Object { ($_.FormatNote.ToString().Trim()) -ieq $selectedRes.ToString().Trim() } | Where-Object { ($_.TBR.ToString().Trim()) -ieq $selectedTBR.ToString().Trim() } |Select-Object -ExpandProperty ID | Sort-Object -Unique -Descending
        $audio_id = $script:audios | Where-Object { $_.FormatNote -eq $script:selectedLang } | Select-Object -ExpandProperty ID
        $button1.Text = "Downloading..."
        $button_reset.Enabled = $false 
        $button_debug.Visible = $false
    

        $proc = New-Object System.Diagnostics.Process
        if ($script:yt_dlp_error -like $true) {$proc.StartInfo.FileName = "$script:yt_dlp_path"} else {$proc.StartInfo.FileName = "yt-dlp.exe"}
        if ($IsRemoteInvocation = $true) {
            if (($script:yt_dlp_error -like $true) -and ($script:multiple_audio -like $false)) {$proc.StartInfo.Arguments = "--ffmpeg-location $script:ffmpeg_path -P $script:selectedPath -f $id+140 $script:url"} elseif ($script:multiple_audio -like $false) {$proc.StartInfo.Arguments = "-P $script:selectedPath -f $id+140 $script:url"}
            if (($script:yt_dlp_error -like $true) -and ($script:multiple_audio -like $true)) {$proc.StartInfo.Arguments = "--ffmpeg-location $script:ffmpeg_path -P $script:selectedPath -f $id+$audio_id $script:url"} elseif ($script:multiple_audio -like $true) {$proc.StartInfo.Arguments = "-P $script:selectedPath -f $id+$audio_id $script:url"}
        } else {
            if (($script:yt_dlp_error -like $true) -and ($script:multiple_audio -like $false)) {$proc.StartInfo.Arguments = "--ffmpeg-location $script:ffmpeg_path -f $id+140 $script:url"} elseif ($script:multiple_audio -like $false) {$proc.StartInfo.Arguments = "-f $id+140 $script:url"}
            if (($script:yt_dlp_error -like $true) -and ($script:multiple_audio -like $true)) {$proc.StartInfo.Arguments = "--ffmpeg-location $script:ffmpeg_path -f $id+$audio_id $script:url"} elseif ($script:multiple_audio -like $true) {$proc.StartInfo.Arguments = "-f $id+$audio_id $script:url"}
        }
        $proc.StartInfo.UseShellExecute = $false
        $proc.StartInfo.RedirectStandardOutput = $true
        $proc.StartInfo.RedirectStandardError = $true
        $proc.StartInfo.CreateNoWindow = $true

        $proc.Start() | Out-Null

        Clear-Host
        # Чтение в реальном времени, без блокировки
        while (-not $proc.HasExited -or -not $proc.StandardOutput.EndOfStream) {
            if (-not $proc.StandardOutput.EndOfStream) {
                $line = $proc.StandardOutput.ReadLine()
    
                if ($line) {
                    # Проверка на ключевые слова
                if ($line -match "Destination" -or $line -match "\[Merger\]" -or $line -match "Deleting" -or $line -match "has already been downloaded") {
                        # Конвертация строки в CP1251
                    $bytes = [System.Text.Encoding]::GetEncoding(866).GetBytes($line)
                    $lineCP1251 = [System.Text.Encoding]::GetEncoding(1251).GetString($bytes)
                    Write-Host $lineCP1251
                } else {
                    # Просто вывод остальных строк
                    Write-Host $line
                }
                }
            } else {
                Start-Sleep -Milliseconds 50
            }
        }

        $proc.WaitForExit()
        Write-Host "Downloaded!"
        $button1.Text = "Download"
        Clear-Host
        
        [System.Media.SystemSounds]::Exclamation.Play()

        $button.Visible = 1
        $button1.Visible = 0
        $button_reset.Enabled = $true
        $button_debug.Visible = $false
        $comboRes.Visible = 0
        $comboTBR.Visible = 0
        $label1.Visible = 0
        $label2.Visible = 0
        $label3.Visible = 0
        $label4.Visible = 0
        $label5.Visible = 0
        $label6.Visible = 0
        $textBox.Enabled = $true
        $button_paste.Visible = 1
        $button_reset.Visible = 0
        $form.Text = "Video download"
        $textBox.Text = ""
    
        $form.Size = New-Object System.Drawing.Size(500,95)
    }
})                 #### готово

#Событие нажатия на кнопку Debug
$button_debug.Add_Click({
    if ($script:debug -eq $false) {
        $script:debug = $true
        Clear-Host
        Write-Host "Debug is now on"

        if ((Test-TikTokUrl -Url $script:url) -like $false) {
            Write-Host "`nAudios:" -NoNewline
            $script:audios | Format-Table | Out-Host
        } else {Write-Host ""}

        Write-Host "Videos:" -NoNewline
        $script:videos | Format-Table | Out-Host
    } elseif ($script:debug -eq $true){
        $script:debug = $false
        Clear-Host
    }
})            #### готово




#Событие при выборе Resolution
$comboRes.Add_SelectedIndexChanged({
    if (Test-TikTokUrl -Url $script:url){
        $selectedRes = $comboRes.SelectedItem
        if ($selectedRes) {
            # Фильтруем массив по выбранной Resolution
            $tbrList = $script:videos | Where-Object {$_.Resolution -eq $selectedRes} | Select-Object -ExpandProperty TBR | Sort-Object -Unique -Descending
            # Гарантируем массив
            if (-not $tbrList) { $tbrList = @() }
            # Очищаем ComboBox и добавляем новые элементы
            $comboTBR.Items.Clear()
            if ($tbrList.Count -gt 0) { 
                $comboTBR.Items.AddRange($tbrList) 
                $comboTBR.SelectedIndex = 0
            }
        }



    } else {
        $selectedRes = $comboRes.SelectedItem
        if ($selectedRes) {
            # Фильтруем массив по выбранной Resolution
            $tbrList = $script:videos | Where-Object { 
                ($_.FormatNote.ToString().Trim()) -ieq $selectedRes.ToString().Trim() 
            } | Select-Object -ExpandProperty TBR | Sort-Object -Unique -Descending

            # Гарантируем массив
            if (-not $tbrList) { $tbrList = @() }
    
            # Очищаем ComboBox и добавляем новые элементы
            $comboTBR.Items.Clear()
            if ($tbrList.Count -gt 0) { 
                $comboTBR.Items.AddRange($tbrList) 
                $comboTBR.SelectedIndex = 0
            }
        }
    }

}) #### готово

#Событие при выборе TBR
$comboTBR.Add_SelectedIndexChanged({
    if (Test-TikTokUrl -Url $script:url){
        $selectedRes = $comboRes.SelectedItem
        $selectedTBR = $comboTBR.SelectedItem

        $size_video = $script:videos | Where-Object {$_.Resolution -eq $selectedRes } | Where-Object { ($_.TBR.ToString().Trim()) -ieq $selectedTBR.ToString().Trim() } |Select-Object -ExpandProperty Raw_size | Sort-Object -Unique -Descending
        $size = $(Format-FileSize $size_video)
        $size_display = $(Format-FileSize $size_video)
        ############################################################################################################################
        $resolution = $script:videos | Where-Object {$_.Resolution -eq $selectedRes } | Where-Object { ($_.TBR.ToString().Trim()) -ieq $selectedTBR.ToString().Trim() } |Select-Object -ExpandProperty Resolution | Sort-Object -Unique -Descending

        if ($script:debug -eq $true){
            Clear-Host
            Write-Host "Videos:" -NoNewline
            $script:videos | Format-Table | Out-Host
            Write-Host "Resolution: $selectedRes `nTBR: $selectedTBR `nSize: $size_display`n" -NoNewline
        }
        $label5.Text = $size
        $label6.Text = $resolution

    } else {
        $selectedRes = $comboRes.SelectedItem
        $selectedTBR = $comboTBR.SelectedItem
        $script:selectedLang = $comboLang.SelectedItem
        ############################################################################################################################
    
        $size_video = $script:videos | Where-Object { ($_.FormatNote.ToString().Trim()) -ieq $selectedRes.ToString().Trim() } | Where-Object { ($_.TBR.ToString().Trim()) -ieq $selectedTBR.ToString().Trim() } |Select-Object -ExpandProperty Raw_size | Sort-Object -Unique -Descending
        $size_audio = $script:audios | Where-Object { ($_.ID.ToString().Trim()) -ieq "140" } |Select-Object -ExpandProperty Raw_size
        $total_size = $size_video + $size_audio
        $size = "~ " + $(Format-FileSize $total_size)
        $size_display = "~ " + $(Format-FileSize $total_size)

        ############################################################################################################################
        $resolution = $script:videos | Where-Object { ($_.FormatNote.ToString().Trim()) -ieq $selectedRes.ToString().Trim() } | Where-Object { ($_.TBR.ToString().Trim()) -ieq $selectedTBR.ToString().Trim() } |Select-Object -ExpandProperty Resolution | Sort-Object -Unique -Descending
        if ($script:debug -eq $true){
            Clear-Host
            Write-Host "`nAudios:" -NoNewline
            $script:audios | Format-Table | Out-Host
            Write-Host "Videos:" -NoNewline
            $script:videos | Format-Table | Out-Host
            Write-Host "Quality: $selectedRes `nTBR: $selectedTBR `nSize: $size_display`nResolution: $resolution`n" -NoNewline
            if ($script:multiple_audio -like $true){ Write-Host "Language: $script:selectedLang" }
        }
        $label5.Text = $size
        $label6.Text = $resolution
    }
}) #### готово

#Событие при выботе Language
$comboLang.Add_SelectedIndexChanged({
    $script:selectedLang = $comboLang.SelectedItem
})#### готово

yt-dlp_test
FFmpeg_test

# Отображаем форму
[void]$form.ShowDialog()
