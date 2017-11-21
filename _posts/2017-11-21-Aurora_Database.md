---
layout: post
title: Aurora Database
date: 2017-10-21
tags: AWS 
---
# Update AWS RDS database to Aurora

Aurora is MySQL compatible and supports auto-scaling. It's highly recommended to use Aurora for higher query speed and lower cost.

Follow these steps to upgrade your current My SQL RDS database to Aurora database

1. **RDS** ->  **Instances**, select the database you want to upgrade. Then click on **Instance Actions** -> **Take Snapshot**, rename your snapshot
2. You can find your snapshot under **Snapshots** (note, if you want to use this snapshot for another account, you can just click on this snapshot -> share snapshot -> type in account ID -> log in another account and you can find it under Snapshots -> Filter ->  Shared with me)
3. We have all the information of the old DB (including data and all SQL accounts information) in this snapshot.  Next step is to build a Aurora DB and import these information. Click on the snapshot -> Migrate snapshot, set up all the configurations and all jobs are done.



Note:

1. When you create a new RDS Aurora instance, it's usually a multi-AZ instance, one has replication role as writer and the other as reader. So you don't need to worry about if one of the instance is down, they always have a back up just like the load balancer. But if you update a Mysql database to Aurora, it's not multi-AZ at the first time, you can add a replication later.