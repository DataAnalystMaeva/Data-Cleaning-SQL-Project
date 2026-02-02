# Data-Cleaning-SQL-Project

SQL Data Cleaning Project: World Layoffs
Project Overview
This project focuses on cleaning a raw dataset of global layoffs using MySQL. The goal was to transform messy data into a reliable source for analysis.

Key Tasks Performed:
Removing Duplicates: Used ROW_NUMBER() and CTE to identify and delete redundant records.

Standardizing Data: Fixed inconsistent naming conventions (e.g., "Crypto", "CryptoCurrency").

Handling Nulls: Implemented logic to populate missing values based on existing data.

Date Formatting: Converted text-based dates into proper DATE format for time-series analysis.

Tools Used:
MySQL Workbench

FRENCH VERSION : 

Projet de Nettoyage de Données SQL : World Layoffs (Licenciements Mondiaux)
Aperçu du Projet
Ce projet porte sur le nettoyage d'un jeu de données brut concernant les licenciements mondiaux à l'aide de MySQL. L'objectif était de transformer des données brutes et incohérentes en une source fiable et exploitable pour l'analyse.

Principales tâches réalisées :
Suppression des doublons : Utilisation de ROW_NUMBER() et de CTE pour identifier et supprimer les enregistrements redondants.

Normalisation des données : Correction des conventions de nommage incohérentes (par exemple, uniformisation de "Crypto" et "CryptoCurrency").

Gestion des valeurs nulles : Mise en œuvre d'une logique métier pour remplir les valeurs manquantes en se basant sur les données existantes du même groupe.

Formatage des dates : Conversion des dates stockées au format texte vers le format DATE approprié pour permettre des analyses temporelles (Time-Series).

Outils utilisés :
Système de gestion de base de données : MySQL

Interface : MySQL Workbench
