﻿Get-Process | Sort-Object -Property WS -Descending | Select-Object -First 10 | Out-File -FilePath "C:\Class\Top10Mem.txt"