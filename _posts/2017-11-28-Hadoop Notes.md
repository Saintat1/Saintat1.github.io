---
layout: post
title: Hadoop setup
date: 2017-10-21
tags: Hadoop 
---
# Hadoop Notes

## Introduction

#### Hadoop common

Basic libraries and utilities

#### Hadoop Yarn: 

1. job scheduling 
2. cluster resource management

#### HDFS(distributed file system)

high-throughput access to data

#### hadoop mapreduce

Yarn-based system for parallel processing

##### The Map Task

takes input data and converts it into a set of data, where individual elements are broken down into tuples (key/value pairs)

##### The Reduce Task 

This task takes the output from a map task as input and combines those data tuples into a smaller set of tuples. The reduce task is always performed after the map task.