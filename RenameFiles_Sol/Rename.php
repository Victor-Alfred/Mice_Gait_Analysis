<?php

$sCSVFileName = __DIR__ . "/labels.csv";
$rFile = fopen("$sCSVFileName", 'r');
if ($rFile === false)
{
	return;
}
$aHeaderRow = fgetcsv($rFile); //skip header in CSv
while ($aFileNames = fgetcsv($rFile))
{
	$sOldFileName  = trim($aFileNames[0]);
	$sNewFileName = trim($aFileNames[1]);

	if(file_exists(__DIR__."/$sOldFileName"))
	{
		rename(__DIR__."/$sOldFileName",  __DIR__."/$sNewFileName");
		echo "Renamed ".__DIR__."/$sOldFileName to ".__DIR__."/$sNewFileName\n";
	}
	else
	{
		echo "Cannot locate ".__DIR__."/$sOldFileName\n";
	}
}