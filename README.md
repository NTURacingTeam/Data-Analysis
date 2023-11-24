# Data-Analysis
Here are scripts based on MATLAB to analyze the data of the NTURT racecar

## Possible Problems
### CRLF & LF
You may encounter warnings when using ```git add```

```
warning: LF will be replacedd by CRLF in <file name>
The file will have its original line endings in your working directory
```
Since Windows uses the CRLF end-of-a-line form and UNIX systems use LF form, the file originally generated in RPi will encounter this warning when being git-added.

To keep the generated data files intact, use the command below and then ```git add``` again
```
git config --global core.autocrlf true
```

