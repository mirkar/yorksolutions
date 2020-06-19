## Comments to Question 2

The example is not 100% functional. For example Load Balancers are missing backend address pool, probes, and rules. Created scale sets do not have backeend adderss pool assigned in ip configuration. But besides all these minor details the environment is completed.
Here is a screenshot of one of two resource groups actually created by terraform:

![Az Environment](https://github.com/mirkar/yorksolutions/blob/master/images/AzEnvironment.png )

I had to create the second scale set not in westus but in westus2, since westus doesn't have B1s image size available, and this is what I normally use in my personal exercises. Scale sets have capacity only 1 instance each to save resources.


![Sketch](https://github.com/mirkar/yorksolutions/blob/master/images/UHDiagram.png)
