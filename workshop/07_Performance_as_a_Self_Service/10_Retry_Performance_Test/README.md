# Retry Performance Test on the previous Version

In this lab you'll remove the slowdown in the carts service to have a solid version. Afterwards, a retry of the performance test should not fail.

## Step 1: Revert the original Behavior of Carts

1. In the directory of `carts\`, open the file: `.\carts\src\main\resources\application.properties`.
1. Change the value of `delayInMillis` from `800` to `0`.
1. Commit/Push the changes to your GitHub Repository *carts*.

## Step 3: Build this new Version

1. Go to **Jenkins** and click on the **sockshop** folder.
1. Click on **carts** and select the **master** branch.
1. Click on **Build Now** to trigger the pipeline.
1. Wait until the pipeline shows: *Success*.

## Step 3: Run Performance Test on new Version

1. Go to **Jenkins** and click on the **sockshop** folder.
1. Click on **carts.performance** and select the **master** branch.  
1. Click on **Build Now** to trigger the performance pipeline.

---

[Previous Step: Compare Tests in Dynatrace](../09_Compare_Tests_in_Dynatrace) :arrow_backward:

:arrow_up_small: [Back to overview](../)