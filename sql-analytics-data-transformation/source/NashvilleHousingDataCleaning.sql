-- Original source work retained with minimal presentation changes.
-- Cleaning the data

SELECT *
FROM PortfolioProject..NashvilleHousing

-- Standardize Date Format
ALTER TABLE NashvilleHousing
ALTER COLUMN [SaleDate] date

-- Populate Property Address
SELECT PropertyAddress
FROM PortfolioProject..NashvilleHousing
WHERE PropertyAddress is null

SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM PortfolioProject..NashvilleHousing A
JOIN PortfolioProject..NashvilleHousing B
    ON A.ParcelID = B.ParcelID
    AND a.[UniqueID ] <> b.[UniqueID ]
WHERE A.PropertyAddress is null

UPDATE A
SET PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM PortfolioProject..NashvilleHousing A
JOIN PortfolioProject..NashvilleHousing B
    ON A.ParcelID = B.ParcelID
    AND a.[UniqueID ] <> b.[UniqueID ]
WHERE A.PropertyAddress is null

-- Break Address into Individual Columns
SELECT
SUBSTRING(PropertyAddress, 1, charindex(',', PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, charindex(',', PropertyAddress) + 1,LEN(PropertyAddress)) AS Address
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing ADD PropertySplitAddress NVARCHAR(255);
UPDATE NashvilleHousing SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, charindex(',', PropertyAddress) - 1)
ALTER TABLE NashvilleHousing ADD PropertySplitCity NVARCHAR(255);
UPDATE NashvilleHousing SET PropertySplitCity = SUBSTRING(PropertyAddress, charindex(',', PropertyAddress) + 1,LEN(PropertyAddress))

-- Owner Address
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing ADD OwnerSpiltAddress Nvarchar(255);
UPDATE NashvilleHousing SET OwnerSpiltAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
ALTER TABLE NashvilleHousing ADD OwnerSpiltCity Nvarchar(255);
UPDATE NashvilleHousing SET OwnerSpiltCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
ALTER TABLE NashvilleHousing ADD OwnerSpiltState Nvarchar(255);
UPDATE NashvilleHousing SET OwnerSpiltState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

-- Change Y and N to Yes and No in SoldAsVacant
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant END

-- Remove Duplicates
WITH RowNumCTE AS (
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY ParcelID, SalePrice, PropertyAddress, SaleDate, LegalReference
        ORDER BY UniqueID
    ) row_num
FROM PortfolioProject..NashvilleHousing
)
DELETE FROM RowNumCTE WHERE row_num > 1

-- Remove unused columns
ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN SaleDate
