"use strict"
var MENUAPP = (function(categories, brands, products)
{
    var categoryCheckboxId = 'cid';
    var categoryCheckboxClass = 'ccl';
    var categoryBrandsClass = 'cb'

    var brandCheckboxId = 'bid';
    var brandCheckboxClass = 'bcl';

    var breadcrumbDetails = [];

    // Product Detail Keys
    /* THREE CATEGORIES list is COMPULASARY.
     * A product can belong to multiple category hierarchies of 3 level.
     */
    var categoryIdsKey = 'categoryIds';
    var brandIdKey = 'brandId';
    var productNameKey = 'productName';
    var productImageKey = 'productImage';

    var partialColor = 'red';
    var defaultColor = '#000000';

    var categoryHierarchy = {};

    // Generating category Hierarchy array
    var generateCategoryHierarchy = function ()
    {
        for (let index in products) {
            for (let categoryIdsIndex in products[index][categoryIdsKey]) {
                let categoryIds = products[index][categoryIdsKey][categoryIdsIndex];
                if (
                    (typeof categoryIds[0] === "undefined") ||
                    (typeof categoryIds[1] === "undefined") ||
                    (typeof categoryIds[2] === "undefined")
                ) {
                    continue;
                }
                let categoryId = categoryIds[0];
                let subCategoryId = categoryIds[1];
                let subSubCategoryId = categoryIds[2];
                if (typeof categoryHierarchy[categoryId] === "undefined") {
                    categoryHierarchy[categoryId] = {};
                    categoryHierarchy[categoryId]['name'] = categories[categoryId];
                }
                if (typeof categoryHierarchy[categoryId]['subCategory'] === "undefined") {
                    categoryHierarchy[categoryId]['subCategory'] = {};
                }
                if (typeof categoryHierarchy[categoryId]['subCategory'][subCategoryId] === "undefined") {
                    categoryHierarchy[categoryId]['subCategory'][subCategoryId] = {};
                    categoryHierarchy[categoryId]['subCategory'][subCategoryId]['name'] = categories[subCategoryId];
                }
                if (typeof categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory'] === "undefined") {
                    categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory'] = {};
                }
                if (typeof categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory'][subSubCategoryId] === "undefined") {
                    categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory'][subSubCategoryId] = {};
                }
                categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory'][subSubCategoryId]['name'] = categories[subSubCategoryId];
            }
        }
    },
    hideId = function(id)
    {
        document.getElementById(id).style.display = "none";
    },
    hideClass = function(className)
    {
        var objs = document.getElementsByClassName(className);
        for (let index = 0, index_length = objs.length; index < index_length; index++) {
            objs[index].style.display = "none";
        }
    },
    displayId = function(id)
    {
        document.getElementById(id).style.display = "block";
    },
    isCheckboxIdChecked = function(id)
    {
        var checked = false;
        var checkbox = document.getElementById(id);
        if (typeof checkbox !== "undefined") {
            checked = checkbox.checked;
        }
        return checked;
    },
    isCheckboxClassChecked = function(className)
    {
        var checked = true;
        var checkboxes = document.getElementsByClassName(className);
        for (let index = 0, index_length = checkboxes.length; index < index_length; index++) {
            if (!checkboxes[index].checked) {
                checked = false;
            }
        }
        return checked;
    },
    getFullIdOrClassName = function(className, categoryId, subCategoryId, subSubCategoryId)
    {
        if (categoryId !== null) {
            className += '-'+categoryId;
        }
        if (subCategoryId !== null) {
            className += '-'+subCategoryId;
        }
        if (subSubCategoryId !== null) {
            className += '-'+subSubCategoryId;
        }
        return className;
    },
    getCategoryJson = function(categoryId, subCategoryId, subSubCategoryId)
    {
        let json = '[';
        if (categoryId !== null) {
            json += categoryId;
        }
        if (subCategoryId !== null) {
            json += ','+subCategoryId;
        }
        if (subSubCategoryId !== null) {
            json += ','+subSubCategoryId;
        }
        json += ']'
        return json;
    },
    generateProductHtml = function(productIds)
    {
        if (productIds.length === 0) {
            var html = '<p align="center" style="color:red;">Zero product found.</p>';
        } else {
            var i = 0;
            var tagClass = '';
            var html = '<div class="gridListingRow"></div>';
            for (let index  in productIds) {
                if (i%4 === 0) {
                    html += '<div class="gridListingRow">';
                }
                if (i%4 === 0) {
                    tagClass = 'gridListingColumnLeft';
                } else if (i%4 === 3) {
                    tagClass = 'gridListingColumnRight';
                } else {
                    tagClass = 'gridListingColumn';
                }
                html += `<div class="${tagClass} displayInlineBlock">
                        <img src="pimage.jpg" width="200" height="200">
                        <div class="productName">${products[index][productNameKey]}</div>
                        <div class="productName">${brands[products[index][brandIdKey]]}</div>
                    </div>`;
                if (i%4 === 3) {
                    html += '</div>';
                }
                i++;
            }
            if (i%4 !== 3) {
                html += '</div>';
            }
        }
        document.getElementById('products').innerHTML = html;
    },
    getActiveBrandIds = function()
    {
        var checkboxes = document.getElementsByClassName(brandCheckboxClass);
        var brandIds = [];
        var i = 0;
        for (let index = 0, i_length = checkboxes.length; index < i_length; index++) {
            if (checkboxes[index].checked) {
                brandIds[i++] = parseInt(checkboxes[index].value);
            }
        }
        return brandIds;
    },
    setCategoryBreadcrum = function(categoryId, subCategoryId, subSubCategoryId, closeMenu)
    {
        let categoryIdOld = null;
        let subCategoryIdOld = null;
        let subSubCategoryIdOld = null;
        if (closeMenu === 'from-breadcrumb') {
            categoryIdOld = breadcrumbDetails[0];
            subCategoryIdOld = breadcrumbDetails[1];
            subSubCategoryIdOld = breadcrumbDetails[2];
        } else if (closeMenu === true) {
            breadcrumbDetails = [categoryId, subCategoryId, subSubCategoryId];
            categoryIdOld = categoryId;
            subCategoryIdOld = subCategoryId;
            subSubCategoryIdOld = subSubCategoryId;
        } else {
            breadcrumbDetails = [];
        }
        var breadcrumHtml = '';
        if (categoryIdOld !== null) {
            breadcrumHtml = 'Categories ::';
            if (
                (subCategoryIdOld !== null) && (subCategoryId === null)
            ) {
                breadcrumHtml += ` ${categories[categoryIdOld]}`;
            } else {
                breadcrumHtml += ` <a href="javascript:void(0);" onClick="obj.displayCategoryProducts(${categoryIdOld}, null, null, 'from-breadcrumb');">${categories[categoryIdOld]}</a>`;
            }
        }
        if (subCategoryIdOld !== null) {
            if (
                ((subCategoryIdOld !== null) && (subCategoryId === null)) ||
                ((subSubCategoryIdOld !== null) && (subSubCategoryId !== null))
            ) {
                breadcrumHtml += ` &gt; <a href="javascript:void(0);" onClick="obj.displayCategoryProducts(${categoryIdOld}, ${subCategoryIdOld}, null, 'from-breadcrumb');">${categories[subCategoryIdOld]}</a>`;
            } else {
                breadcrumHtml += ` &gt; ${categories[subCategoryIdOld]}`;
            }
        }
        if (subSubCategoryIdOld !== null) {
            if (subSubCategoryId === null) {
                breadcrumHtml += ` &gt; <a href="javascript:void(0);" onClick="obj.displayCategoryProducts(${categoryIdOld}, ${subCategoryIdOld}, ${subSubCategoryIdOld}, 'from-breadcrumb');">${categories[subSubCategoryIdOld]}</a>`;
            } else {
                breadcrumHtml += ` &gt; ${categories[subSubCategoryIdOld]}`;
            }
        }
        document.getElementById('breadcrum').innerHTML = breadcrumHtml;
    },
    setBrandBreadcrum = function(brandId)
    {
        var breadcrumHtml = '';
        if (brandId !== null) {
            breadcrumHtml = `Brand :: ${brands[brandId]}`;
        }
        document.getElementById('breadcrum').innerHTML = breadcrumHtml;
    },
    displayCategoryProducts = function(categoryId, subCategoryId, subSubCategoryId, closeMenu)
    {
        this.setCategoryBreadcrum(categoryId, subCategoryId, subSubCategoryId, closeMenu);
        // Close Menu code
        if (closeMenu === true) {
            this.hideClass('subMenu');
        }
        let showAllProducts = false;
        if (
            categoryId === null &&
            subCategoryId === null &&
            subSubCategoryId === null
        ) {
            showAllProducts = true;
        }
        let brandIds = getActiveBrandIds();
        let productIds = [];
        for (let index in products) {
            if (brandIds.indexOf(products[index][brandIdKey]) === -1) {
                continue;
            }
            if (showAllProducts) {
                productIds[index] = index;
                continue;
            }
            let found = false;
            for (let categoryIdsIndex in products[index][categoryIdsKey]) {
                let categoryIds = products[index][categoryIdsKey][categoryIdsIndex];
                switch (true) {
                    case subSubCategoryId !== null:
                        if (
                            subSubCategoryId === categoryIds[2] &&
                            subCategoryId === categoryIds[1] &&
                            categoryId === categoryIds[0]
                        ) {
                            productIds[index] = index;
                        }
                        found = true;
                        break;
                    case subCategoryId !== null:
                        if (
                            subCategoryId === categoryIds[1] &&
                            categoryId === categoryIds[0]
                        ) {
                            productIds[index] = index;
                        }
                        found = true;
                        break;
                    case categoryId !== null:
                        if (categoryId === categoryIds[0]) {
                            productIds[index] = index;
                        }
                        found = true;
                        break;
                }
                if (found) break;
            }
        }
        this.generateProductHtml(productIds);
    },
    displayCheckboxProducts = function(mode)
    {
        this.setCategoryBreadcrum(null, null, null, false);
        var productIds = [];
        if (this.isCheckboxIdChecked(categoryCheckboxId)) {
            // Display Product
            var brandIds = getActiveBrandIds();
            var productIds = [];
            for (let index in products) {
                if (brandIds.indexOf(products[index][brandIdKey]) === -1) {
                    continue;
                }
                for (let categoryIdsIndex in products[index][categoryIdsKey]) {
                    let categoryIds = products[index][categoryIdsKey][categoryIdsIndex];
                    if (this.isCheckboxIdChecked(`${categoryCheckboxId}-${categoryIds[0]}-${categoryIds[1]}-${categoryIds[2]}`)) {
                        productIds[index] = index;
                        break;
                    }
                }
            }
        }
        this.generateProductHtml(productIds);
    },
    getSelectedCategories = function(categoryId)
    {
        let selectedCategories = {};
        let className = this.getFullIdOrClassName(categoryCheckboxClass, categoryId, null, null);
        var checkboxes = document.getElementsByClassName(className);
        for (let index = 0, index_length = checkboxes.length; index < index_length; index++) {
            if (checkboxes[index].checked) {
                let json = JSON.parse(checkboxes[index].value);
                if (json.length === 3) {
                    if (typeof selectedCategories[json[0]] === "undefined") {
                        selectedCategories[json[0]] = {};
                    }
                    if (typeof selectedCategories[json[0]][json[1]] === "undefined") {
                        selectedCategories[json[0]][json[1]] = {};
                    }
                    if (typeof selectedCategories[json[0]][json[1]][json[2]] === "undefined") {
                        selectedCategories[json[0]][json[1]][json[2]] = {};
                    }
                    selectedCategories[json[0]][json[1]][json[2]] = true;
                }
            }
        }
        return selectedCategories;
    },
    updateBrands = function(categoryId)
    {
        if (categoryId === null) {
            let categoryBrands = document.getElementsByClassName(categoryBrandsClass);
            for (let index = 0, index_length = categoryBrands.length; index < index_length; index++) {
                categoryBrands[index].innerHTML = '';
            }
            return;
        }
        let selectedCategories = this.getSelectedCategories(categoryId);
        var brandIds = getActiveBrandIds();
        var brandCount = [];
        for (let index in products) {
            let found = false;
            for (let categoryIdsIndex in products[index][categoryIdsKey]) {
                let categoryIds = products[index][categoryIdsKey][categoryIdsIndex];
                if (
                    typeof selectedCategories[categoryIds[0]] !== "undefined" &&
                    typeof selectedCategories[categoryIds[0]][categoryIds[1]] !== "undefined" &&
                    typeof selectedCategories[categoryIds[0]][categoryIds[1]][categoryIds[2]] !== "undefined"
                ) {
                    found = true;
                    break;
                }
            }
            if (found) {
                let brandId = products[index][brandIdKey];
                if (brandIds.indexOf(brandId) === -1) {
                    continue;
                }
                if (typeof brandCount[brandId] === "undefined") {
                    brandCount[brandId] = 0;
                }
                brandCount[brandId]++;
            }
        }
        var html = '';
        if (brandCount.length > 0) {
            var html = '<table width="100%" cellpadding="0" cellspacing="5">';
            var i = 0;
            for (let brandId in brands) {
                if (typeof brandCount[brandId] !== "undefined") {
                    if (i%4 === 0) {
                        html += '<tr>';
                    }
                    html += `<td width="150" class="brand" align="left" onClick="obj.displayCategoryBrandProducts(${categoryId}, ${brandId})">${brands[brandId]} (${brandCount[brandId]})</td>`;
                    if (i%4 === 3) {
                        html += '<tr>';
                    }
                    i++;
                }
            }
            for (i = i%4; i < 4; i++) {
                if (i%4 === 0) {
                    html += '<tr>';
                }
                html += '<td width="150">&nbsp;</td>';
                if (i%4 === 3) {
                    html += '<tr>';
                }
            }
            html += '</table>';
        }
        document.getElementById(`${categoryBrandsClass}-${categoryId}`).innerHTML = html;
    },
    adjustCategoryCheckbox = function(categoryId, subCategoryId, subSubCategoryId)
    {
        let id = this.getFullIdOrClassName(categoryCheckboxId, categoryId, subCategoryId, subSubCategoryId);
        let className = this.getFullIdOrClassName(categoryCheckboxClass, categoryId, subCategoryId, subSubCategoryId);
        let json = this.getCategoryJson(categoryId, subCategoryId, subSubCategoryId);
        let allChecked = true;
        let allUnChecked = true;
        var checkboxes = document.getElementsByClassName(className);
        for (let index = 0, index_length = checkboxes.length; index < index_length; index++) {
            if (subSubCategoryId === null && json === checkboxes[index].value) {
                 continue;
            }
            if (checkboxes[index].checked) {
                allUnChecked = false;
            } else {
                allChecked = false;
            }
        }
        if (allChecked) {
            document.getElementById(id).checked = true;
        } else if (allUnChecked) {
            document.getElementById(id).checked = false;
        } else {
            document.getElementById(id).checked = true;
        }
        if (id !== categoryCheckboxId) {
            if (allChecked) {
                document.getElementById(id).style.color = defaultColor;
            } else if (allUnChecked) {
                document.getElementById(id).style.color = defaultColor;
            } else {
                document.getElementById(id).style.color = partialColor;    
            }
        }
        switch (true) {
            case subSubCategoryId !== null:
                this.adjustCategoryCheckbox(categoryId, subCategoryId, null);
                break;
            case subCategoryId !== null:
                this.adjustCategoryCheckbox(categoryId, null, null);
                break;
            case categoryId !== null:
                this.adjustCategoryCheckbox(null, null, null);
                break;
        }
    },
    adjustBrandCheckbox = function(brandId)
    {
        let className = brandCheckboxClass;
        let allChecked = true;
        let allUnChecked = true;
        var checkboxes = document.getElementsByClassName(className);
        for (let index = 0, index_length = checkboxes.length; index < index_length; index++) {
            if (checkboxes[index].id === brandCheckboxId) {
                 continue;
            }
            if (checkboxes[index].checked) {
                allUnChecked = false;
            } else {
                allChecked = false;
            }
        }
        if (allChecked) {
            document.getElementById(brandCheckboxId).checked = true;
            document.getElementById(brandCheckboxId).style.color = defaultColor;
        } else if (allUnChecked) {
            document.getElementById(brandCheckboxId).checked = false;
            document.getElementById(brandCheckboxId).style.color = defaultColor;
        } else {
            document.getElementById(brandCheckboxId).checked = true;
            document.getElementById(brandCheckboxId).style.color = partialColor;    
        }
    },
    categoryCheckboxClicked = function(categoryId, subCategoryId, subSubCategoryId, checked)
    {
        this.setCategoryBreadcrum(null, null, null, false);
        if (categoryId === null) {
            var checkboxes = document.getElementsByClassName(categoryCheckboxClass);
            for (let index = 0, index_length = checkboxes.length; index < index_length; index++) {
                if (checkboxes[index].id !== categoryCheckboxId) {
                    checkboxes[index].checked = checked;
                    checkboxes[index].style.color = defaultColor;
                }
            } 
        } else {
            var className = this.getFullIdOrClassName(categoryCheckboxClass, categoryId, subCategoryId, subSubCategoryId);
            var checkboxes = document.getElementsByClassName(className);
            for (let index = 0, index_length = checkboxes.length; index < index_length; index++) {
                checkboxes[index].checked = checked;
            }    
            this.adjustCategoryCheckbox(categoryId, subCategoryId, subSubCategoryId);
        }
        if (categoryId === null) {
            for (let categoryId in categoryHierarchy) {
                this.updateBrands(categoryId);
            }    
        } else {
            this.updateBrands(categoryId);
        }
        this.displayCheckboxProducts('inline');
    },
    brandCheckboxClicked = function(brandId, checked)
    {
        this.setBrandBreadcrum(null);
        var set = false;
        if (brandId === null) {
            set = true;
        }
        var checkboxes = document.getElementsByClassName(brandCheckboxClass);
        var color = defaultColor;
        for (let index = 0, index_length = checkboxes.length; index < index_length; index++) {
            if (set) {
                checkboxes[index].checked = checked;
                continue;
            } 
            if (!checkboxes[index].checked) {
                color = partialColor;
                break;
            }
        }
        this.adjustBrandCheckbox(brandId);
        for (let categoryId in categoryHierarchy) {
            this.updateBrands(categoryId);
        }
        this.displayCheckboxProducts('inline');
    },
    displayCategoryBrandProducts = function(categoryId, brandId)
    {
        let selectedCategories = this.getSelectedCategories(categoryId);
        var brandIds = getActiveBrandIds();
        var productIds = [];
        for (let index in products) {
            let found = false;
            for (let categoryIdsIndex in products[index][categoryIdsKey]) {
                let categoryIds = products[index][categoryIdsKey][categoryIdsIndex];
                if (
                    typeof selectedCategories[categoryIds[0]] !== "undefined" &&
                    typeof selectedCategories[categoryIds[0]][categoryIds[1]] !== "undefined" &&
                    typeof selectedCategories[categoryIds[0]][categoryIds[1]][categoryIds[2]] !== "undefined" &&
                    brandId == products[index][brandIdKey] &&
                    brandIds.indexOf(products[index][brandIdKey]) !== -1
                ) {
                    found = true;
                    break;
                }
            }
            if (found) {
                productIds[index] = index;
            }
        }
        this.generateProductHtml(productIds);
    },
    displayBrandProducts = function(brandId)
    {
        this.setBrandBreadcrum(brandId);
        var productIds = [];
        for (let index in products) {
            if (brandId == products[index][brandIdKey]) {
                productIds[index] = index;
            }
        }
        this.generateProductHtml(productIds);
    },
    getCategoryCheckboxAttributes = function(categoryId, subCategoryId, subSubCategoryId)
    {
        let id = this.getFullIdOrClassName(categoryCheckboxId, categoryId, subCategoryId, subSubCategoryId);
        let className = categoryCheckboxClass;
        let onClick = `obj.categoryCheckboxClicked(${categoryId}, ${subCategoryId}, ${subSubCategoryId}, this.checked);`;
        if (categoryId !== null) {
            className += ' '+this.getFullIdOrClassName(categoryCheckboxClass, categoryId, null, null);
        }
        if (subCategoryId !== null) {
            className += ' '+this.getFullIdOrClassName(categoryCheckboxClass, categoryId, subCategoryId, null);
        }
        if (subSubCategoryId !== null) {
            className += ' '+this.getFullIdOrClassName(categoryCheckboxClass, categoryId, subCategoryId, subSubCategoryId);
        }
        let val = this.getCategoryJson(categoryId, subCategoryId, subSubCategoryId);
            
        return `id="${id}" class="${className}" value="${val}" onClick="${onClick}" checked`;
    },
    genMenu = function()
    {
        var is = {};
        var html = `
            <div class="displayInlineBlock">
                <div>
                    <span onClick="obj.categoryCheckboxClicked(null, null, null, true);" style="color:Blue;cursor:pointer;"><a hredf="javascript:void(0);"><b>Home</b></a></span>
                </div>
            </div>`;
        for (let categoryId in categoryHierarchy) {
            is[categoryId] = categoryId;
            html += `
            <div class="padl displayInlineBlock">
                <div onmouseleave="obj.hideId('subMenu-${categoryId}');">
                    <span onmouseenter="obj.displayId('subMenu-${categoryId}');">
                        <div style="float:left;"><input type="checkbox" ${this.getCategoryCheckboxAttributes(categoryId, null, null)}/></div>&nbsp;<span onClick="obj.displayCategoryProducts(${categoryId},null,null, true)"><a href="javascript:void(0);">${categoryHierarchy[categoryId]['name']}</a></span>
                    </span>
                    <!-- Sub Menu start-->
                    <div class="subMenu" id="subMenu-${categoryId}">`;
            if (typeof categoryHierarchy[categoryId]['subCategory'] !== "undefined") {
                html += `
                        <table width="600" height="200" cellpadding="0" cellspacing="5">
                            <tr>
                                <td class="collapse" width="200" valign="top">
                                    <table width="200" cellpadding="0" cellspacing="2">`;
                for (let subCategoryId in categoryHierarchy[categoryId]['subCategory']) {
                                        html += `
                                        <tr>
                                            <td>
                                                <table width="100%" cellpadding="0" cellspacing="2">
                                                    <tr>
                                                        <td width="17" align="center"><input type="checkbox" ${this.getCategoryCheckboxAttributes(categoryId, subCategoryId, null)}/></td>
                                                        <td class="subMenus" align="left" onmouseenter="obj.hideClass('subSubMenu');obj.displayId('subSubMenu-${categoryId}-${subCategoryId}');" onClick="obj.displayCategoryProducts(${categoryId}, ${subCategoryId},null, true)"><a href="javascript:void(0);">${categoryHierarchy[categoryId]['subCategory'][subCategoryId]['name']}</a></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>`;
                }
                                    html += `
                                    </table>
                                </td>
                                <td class="collapse" width="400" valign="top">`;
                for (let subCategoryId in categoryHierarchy[categoryId]['subCategory']) {
                                    html += `
                                    <div id="subSubMenu-${categoryId}-${subCategoryId}" class="subSubMenu hide">`;
                    if (typeof categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory'] !== "undefined") {
                                        html += `
                                        <table width="100%" cellpadding="0" cellspacing="2">
                                            <tr>
                                                <td valign="top">
                                                    <table width="100%" cellpadding="0" cellspacing="2">
                                                        <tr>`;
                        for (let subSubCategoryId in categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory']) {
                                                html += `
                                                <tr>
                                                    <td>
                                                        <table width="100%" cellpadding="0" cellspacing="2">
                                                            <tr>
                                                                <td width="17" align="center"><input type="checkbox" ${this.getCategoryCheckboxAttributes(categoryId, subCategoryId, subSubCategoryId)}/></td>
                                                                <td class="subSubMenus" align="left" onClick="obj.displayCategoryProducts(${categoryId}, ${subCategoryId}, ${subSubCategoryId}, true)"><a href="javascript:void(0);">${categoryHierarchy[categoryId]['subCategory'][subCategoryId]['subCategory'][subSubCategoryId]['name']}</a></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>`;
                        }
                                            html += `
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>`;
                    }
                                    html += `
                                    </div>`;
                }
                                html += `
                                </td>
                            </tr>
                            <tr>
                                <td height="27" valign="top" colspan="2" class="collapse ${categoryBrandsClass}" id="${categoryBrandsClass}-${categoryId}">
                                </td>
                            </tr>
                        </table>`;
            }
                    html += `
                    </div>
                </div>
            </div>`;
        }
        html += `
            <div class="padl displayInlineBlock">
                <div onmouseleave="obj.hideId('subMenu-brand');">
                    <span onmouseenter="obj.displayId('subMenu-brand');">
                        <div style="float:left;"><input type="checkbox" id="${brandCheckboxId}" class="${brandCheckboxClass}" checked class="brandBacklink" onClick="obj.brandCheckboxClicked(null, this.checked);"/></div>&nbsp;<span>Brands</span>
                    </span>
                    <!-- Sub Menu start-->
                    <div class="subMenu" id="subMenu-brand">`;
                    html += `
                        <table width="200" cellpadding="0" cellspacing="5">`;
                for (let brandId in brands) {
                        html += `
                            <tr>
                                <td width="200" valign="top">
                                    <table width="100%" cellpadding="0" cellspacing="2">
                                        <tr>
                                            <td width="17" align="center"><input type="checkbox" id="${brandCheckboxId}-${brandId}" class="${brandCheckboxClass} ${brandCheckboxClass}-${brandId}" checked  value="${brandId}" onClick="obj.brandCheckboxClicked(${brandId}, this.checked);"/></td>
                                            <td class="subMenus" align="left" onClick="obj.displayBrandProducts(${brandId})"><a href="javascript:void(0);">${brands[brandId]}</a></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>`;
                }
                    html += `
                        </table>
                    </div>
                </div>
            </div>`;

        document.getElementById('menu').innerHTML = html;
        this.displayCategoryProducts(null, null, null, false);
        for (let index in is) {
            this.updateBrands(index);
        }
    };

    var nsp = {};
    
    nsp.generateCategoryHierarchy = generateCategoryHierarchy;
    nsp.hideId = hideId;
    nsp.hideClass = hideClass;
    nsp.displayId = displayId;
    nsp.isCheckboxIdChecked = isCheckboxIdChecked;
    nsp.isCheckboxClassChecked = isCheckboxClassChecked;
    nsp.getActiveBrandIds = getActiveBrandIds;
    nsp.getFullIdOrClassName = getFullIdOrClassName;
    nsp.getCategoryJson = getCategoryJson;
    nsp.getSelectedCategories = getSelectedCategories;
    nsp.generateProductHtml = generateProductHtml;
    nsp.setCategoryBreadcrum = setCategoryBreadcrum;
    nsp.setBrandBreadcrum = setBrandBreadcrum;
    nsp.displayCategoryProducts = displayCategoryProducts;
    nsp.displayCheckboxProducts = displayCheckboxProducts;
    nsp.updateBrands = updateBrands;
    nsp.adjustCategoryCheckbox = adjustCategoryCheckbox;
    nsp.adjustBrandCheckbox = adjustBrandCheckbox;
    nsp.categoryCheckboxClicked = categoryCheckboxClicked;
    nsp.brandCheckboxClicked = brandCheckboxClicked;
    nsp.displayCategoryBrandProducts = displayCategoryBrandProducts;
    nsp.displayBrandProducts = displayBrandProducts;
    nsp.getCategoryCheckboxAttributes = getCategoryCheckboxAttributes;
    nsp.genMenu = genMenu;

    return nsp;
});
