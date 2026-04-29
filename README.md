# SGBD Project - Showroom Auto Management

This project is an Oracle SQL, PL/SQL and Oracle APEX application developed for a university Database Management Systems course.

The application models the activity of an auto showroom and manages information about clients, cars, employees, sales, test drives and payments.

## Project Overview

The project started as a relational database project and was later extended with PL/SQL components and an Oracle APEX application.

The database is designed for managing the main operations of an auto showroom:

- storing client information;
- managing cars available or sold;
- storing employee information;
- recording car sales;
- recording test drives;
- managing payments for sales.

## Technologies Used

- Oracle Database
- Oracle SQL Developer
- PL/SQL
- Oracle APEX
- SQL / DDL / DML

## Database Tables

The database contains the following main tables:

| Table | Description |
|---|---|
| `SR_CLIENTI` | Stores information about showroom clients |
| `SR_MASINI` | Stores information about cars |
| `SR_ANGAJATI` | Stores information about employees |
| `SR_VANZARI` | Stores sales transactions |
| `SR_TESTDRIVE` | Stores test drive records |
| `SR_PLATI` | Stores payments related to sales |

## Database Features

The SQL part of the project includes:

- table creation using DDL commands;
- primary key constraints;
- foreign key constraints;
- `CHECK` constraints;
- `NOT NULL` constraints;
- `UNIQUE` constraint;
- data insertion using DML commands;
- update operations;
- views;
- indexes;
- sequences;
- synonyms;
- different SQL queries using joins, subqueries, grouping, ordering, `CASE`, `DECODE`, `UNION`, `INTERSECT`, `MINUS` and hierarchical queries.

## PL/SQL Features

The SGBD extension of the project includes PL/SQL components such as:

- alternative structures: `IF...ELSIF...ELSE`, `CASE`;
- repetitive structures: `FOR LOOP`, `WHILE LOOP`, `LOOP...EXIT WHEN`;
- implicit and explicit exception handling;
- implicit and explicit cursors;
- functions;
- procedures;
- package specification and package body;
- database triggers.

## Exception Handling

The project contains examples of both implicit and explicit exceptions.

Implicit exceptions used:

- `NO_DATA_FOUND`;
- `DUP_VAL_ON_INDEX`.

Explicit exceptions used:

- custom exception for invalid car price;
- custom exception for payment amount exceeding the remaining balance.

## Cursors

The project contains examples of:

- implicit cursor using `SQL%ROWCOUNT`;
- explicit cursor without parameters;
- explicit cursor with parameters;
- cursor used with `FOR LOOP`.

## Functions, Procedures and Package

The project includes a PL/SQL package named:

```
PACKAGE_SHOWROOM_SGBD
```

## How to Open / Import the Oracle APEX Application

The Oracle APEX application is exported as a `.sql` file and stored in:

```text
apex/showroom_auto_apex_export.sql
