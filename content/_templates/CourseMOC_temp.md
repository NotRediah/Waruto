---
class:
  - moc
created_on: "[[<% tp.date.now('MM-DD-YYYY') %>]]"
tags:
  - moc
  - course
source:
related:
author:
description:
aliases:
status: open
---
# {{title}}

## Overview

## Lectures
```dataview
TABLE topics-covered AS "Topics", created_on AS "Date"
FROM "400 Knowledge/Uni"
WHERE type = "lecture" AND contains(source, this.file.name)
SORT created_on ASC
```

## Assignments
- [ ] 

## Resources
- Syllabus:
- Textbook:

## Grade Tracker
| Assessment | Max Marks | Obtained | Date |
| ---------- | --------- | -------- | ---- |
|            |           |          |      |

## Notes
