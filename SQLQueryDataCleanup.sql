
select * 
from NashvilleHousing
order by UniqueID asc
--Standardize date format

Select SaleDate, CONVERT(DATE,SaleDate)
from NashvilleHousing

UPDATE NashvilleHousing
Set SaleDate = Convert (Date, SaleDate)


--Populate Property Adress Data

Select count(*)
FROM NashvilleHousing
--where PropertyAddress is null

Select a.UniqueID,a.ParcelID, a.PropertyAddress ,b.UniqueID, b.ParcelID, b.PropertyAddress , ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null


--Breaking Adress into individual collumns
--Using SUBSTRING
select PropertyAddress, substring(PropertyAddress,1,charindex(',', PropertyAddress)) as Address,
--substring(PropertyAddress , charindex(' ', PropertyAddress)+1, charindex(',', PropertyAddress)) as Address,
substring(PropertyAddress ,charindex(',' ,PropertyAddress) +1, len(PropertyAddress)) as City
from NashvilleHousing
order by ParcelID

ALTER TABLE NashvilleHousing
Add PropertySplitAddress nvarchar(255);

UPDATE NashvilleHousing 
Set PropertySplitAddress = substring(PropertyAddress,1,charindex(',', PropertyAddress))


ALTER TABLE NashvilleHousing
Add PropertySplitCity nvarchar(255);

UPDATE NashvilleHousing 
Set PropertySplitCity = substring(PropertyAddress ,charindex(',' ,PropertyAddress) +1, len(PropertyAddress))


--Using Parse

SELECT OwnerAddress
FROM NashvilleHousing

SELECT PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

UPDATE NashvilleHousing 
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity nvarchar(255);

UPDATE NashvilleHousing 
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState nvarchar(255);

UPDATE NashvilleHousing 
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)



-- Updating Y and N to Yes and No in "Sold as Vacant" column


SELECT DISTINCT(SoldAsVacant), COUNT(*)
FROM NashvilleHousing
GROUP BY SoldAsVacant


SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' then 'Yes'
     WHEN SoldAsVacant = 'N' then 'No'
	 ELSE SoldAsVacant END
FROM NashvilleHousing
GROUP BY SoldAsVacant

Update NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' then 'Yes'
     WHEN SoldAsVacant = 'N' then 'No'
	 ELSE SoldAsVacant END
	 

--Remove Duplicates
WITH RowNumCTE AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY UniqueID) row_num
FROM NashvilleHousing)
SELECT * 
FROM RowNumCTE
WHERE row_num>1
order by PropertyAddress

DELETE  
FROM RowNumCTE
WHERE row_num>1



SELECT * 
FROM RowNumCTE
WHERE row_num>1
order by PropertyAddress


--Delete Unused Columns

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress








