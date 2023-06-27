var MENUAPP = (function(categories, brands, products)
{
    var partialColor = 'orange';
    var defaultColor = '#000000';

    var categoryHierarchy = {};

    // Generating category Hierarchy array
    var generateCategoryHierarchy = function ()
    {
        for(i in products) {
            if (
                (typeof products[i]['categoryIds'][0] === "undefined") ||
                (typeof products[i]['categoryIds'][1] === "undefined") ||
                (typeof products[i]['categoryIds'][2] === "undefined")
            ) {
                continue;
            }
            var zero = products[i]['categoryIds'][0];
            var one = products[i]['categoryIds'][1];
            var two = products[i]['categoryIds'][2];
            if (typeof categoryHierarchy[zero] === "undefined") {
                categoryHierarchy[zero] = {};
                categoryHierarchy[zero]['name'] = categories[zero];
            }
            if (typeof categoryHierarchy[zero]['subCategory'] === "undefined") {
                categoryHierarchy[zero]['subCategory'] = {};
            }
            if (typeof categoryHierarchy[zero]['subCategory'][one] === "undefined") {
                categoryHierarchy[zero]['subCategory'][one] = {};
                categoryHierarchy[zero]['subCategory'][one]['name'] = categories[one];
            }
            if (typeof categoryHierarchy[zero]['subCategory'][one]['subCategory'] === "undefined") {
                categoryHierarchy[zero]['subCategory'][one]['subCategory'] = {};
            }
            if (typeof categoryHierarchy[zero]['subCategory'][one]['subCategory'][two] === "undefined") {
                categoryHierarchy[zero]['subCategory'][one]['subCategory'][two] = {};
            }
            categoryHierarchy[zero]['subCategory'][one]['subCategory'][two]['name'] = categories[two];
        }
    },
    pad = function(pad, str, padLeft) {
        pad = '0000000000';
        if (typeof str === 'undefined') 
            return pad;
        if (padLeft) {
            return (pad + str).slice(-pad.length);
        } else {
            return (str + pad).substring(0, pad.length);
        }
    },
    display = function(id)
    {
        document.getElementById(id).style.display = "block";
    },
    hide = function(id)
    {
        document.getElementById(id).style.display = "none";
    },
    displaySubMenu = function(id)
    {
        this.display(`subMenu-${id}`);
    },
    displaySubSubMenu = function(i, j)
    {
        let iPad = this.pad('00', i, true);
        let jPad = this.pad('00', j, true);

        var subSubMenus = document.getElementsByClassName('subSubMenu');
        for (let i = 0, i_length = subSubMenus.length; i < i_length; i++) {
            subSubMenus[i].style.display = "none";
        }
        this.display(`subSubMenu-${iPad}-${jPad}`);
    },
    generateProductHtml = function(productIds)
    {
        if (productIds.length === 0) {
            var html = '<p align="center" style="color:red;">Zero product found.</p>';
        } else {
            var i = 0;
            var tagClass = '';
            var html = '<div class="gridListingRow"></div>';
            for (index  in productIds) {
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
                html += '' +
                    '<div class="' + tagClass + ' displayInlineBlock">' +
                        '<img src="pimage.jpg" width="200" height="200">' +
                        '<div class="productName">' + products[index]['productName'] + '</div>' +
                    '</div>';
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
    displayProduct = function(i, j, k, closeMenu)
    {
        // Close Menu code
        if (closeMenu === true) {
            var subMenus = document.getElementsByClassName('subMenu');
            for (let i = 0, i_length = subMenus.length; i < i_length; i++) {
                subMenus[i].style.display = "none";
            }
        }
        var productIds = [];
        // Display Product
        for (index in products) {
            switch (true) {
                case k !== null:
                    if (
                        k === products[index]['categoryIds'][2] &&
                        j === products[index]['categoryIds'][1] &&
                        i === products[index]['categoryIds'][0]
                    ) {
                        productIds[index] = index;
                    }
                    break;
                case j !== null:
                    if (
                        j === products[index]['categoryIds'][1] &&
                        i === products[index]['categoryIds'][0]
                    ) {
                        productIds[index] = index;
                    }
                    break;
                case i !== null:
                    if (i === products[index]['categoryIds'][0]) {
                        productIds[index] = index;
                    }
                    break;
                default:
                    productIds[index] = index;
                    break;
            }
        }
        this.generateProductHtml(productIds);
    },
    checkboxIdChecked = function(id)
    {
        var checked = false;
        var checkbox = document.getElementById(id);
        if (typeof checkbox !== "null") {
            checked = checkbox.checked;
        }
        return checked;
    },
    setCheckboxStatusByClass = function(className, status)
    {
        var checkboxes = document.getElementsByClassName(className);
        for (let i = 0, i_length = checkboxes.length; i < i_length; i++) {
            checkboxes[i].checked = status;
        }
    },
    checkCheckboxClassChecked = function(className)
    {
        var checked = true;
        var checkboxes = document.getElementsByClassName(className);
        for (let i = 0, i_length = checkboxes.length; i < i_length; i++) {
            if (checkboxes[i].checked === false) {
                checked = false;
                break;
            }
        }
        return checked;
    },
    displayCheckboxProduct = function(mode)
    {
        if (
            (this.checkboxIdChecked('searchCheckbox') && mode === 'inline') ||
            (!this.checkboxIdChecked('searchCheckbox') && mode === 'search')
        ) {
            var productIds = [];
            if (this.checkboxIdChecked('allCategoryCheckbox')) {
                // Display Product
                for (index in products) {
                    let kPad = this.pad('00', products[index]['categoryIds'][2], true);
                    let jPad = this.pad('00', products[index]['categoryIds'][1], true);
                    let iPad = this.pad('00', products[index]['categoryIds'][0], true);
                    if (this.checkboxIdChecked(`categoryCheckboxId-${iPad}-${jPad}-${kPad}`)) {
                        productIds[index] = index;
                    }
                }
            }
            this.generateProductHtml(productIds);
        }
    },
    updateBrands = function(categoryId)
    {
        if (categoryId === null) {
            var brands = document.getElementsByClassName('brands');
            for (let i = 0, i_length = brands.length; i < i_length; i++) {
                brands[i].innerHTML = '';
            }
            return;
        }
        let iPad = this.pad('00', categoryId, true);
        var arr = {};
        var checkboxes = document.getElementsByClassName(`brands-${iPad}`);
        for (let i = 0, j = 0, i_length = checkboxes.length; i < i_length; i++) {
            if (checkboxes[i].checked) {
                var json = JSON.parse(checkboxes[i].value);
                if (typeof arr[json[0]] === "undefined") {
                    arr[json[0]] = {};
                }
                if (typeof arr[json[0]][json[1]] === "undefined") {
                    arr[json[0]][json[1]] = {};
                }
                if (typeof arr[json[0]][json[1]][json[2]] === "undefined") {
                    arr[json[0]][json[1]][json[2]] = {};
                }
            }
        }
        var brandCount = [];
        for(index in products) {
            i = products[index]['categoryIds'][0];
            j = products[index]['categoryIds'][1];
            k = products[index]['categoryIds'][2];
            if (
                (typeof arr[i] !== "undefined") &&
                (typeof arr[i][j] !== "undefined") &&
                (typeof arr[i][j][k] !== "undefined")                        
            ) {
                if (typeof brandCount[products[index]['brandId']] === "undefined") {
                    brandCount[products[index]['brandId']] = 0;
                }
                brandCount[products[index]['brandId']]++;
            }
        }
        var html = '';
        if (brandCount.length > 0) {
            var html = '<table width="100%" cellpadding="0" cellspacing="5">';
            var i = 0;
            for(index in brands) {
                if (typeof brandCount[index] !== "undefined") {
                    if (i%4 === 0) {
                        html += '<tr>';
                    }
                    html += '<td width="150" class="brand" align="left" onCLick="displayBrandProducts(' + categoryId + ',' + index + ')">' + brands[index] + ' (' + brandCount[index] + ')</td>';
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
        document.getElementById(`brands-${iPad}`).innerHTML = html;
    },
    changeCheckboxBorderColor = function(className, color)
    {
        var checkboxes = document.getElementsByClassName(className);
        for (let i = 0, i_length = checkboxes.length; i < i_length; i++) {
            checkboxes[i].style.color = color;
        }
    },
    backlink = function(i, j, k, checked)
    {
        var allChecked = null;
        var color = null;
        if (k !== null) {
            let kPad = this.pad('00', k, true);
            let jPad = this.pad('00', j, true);
            let iPad = this.pad('00', i, true);
            if (checked && this.checkCheckboxClassChecked(`categoryCheckbox-${iPad}-${jPad}`)) {
                color = defaultColor;
            } else {
                color = partialColor;
            }
            this.changeCheckboxBorderColor(`categoryBacklink-${iPad}-${jPad}`, color);
            if (checked && this.checkCheckboxClassChecked(`categoryCheckbox-${iPad}`)) {
                color = defaultColor;
            } else {
                color = partialColor;
            }
            this.changeCheckboxBorderColor(`categoryBacklink-${iPad}`, color);
        } else if (j !== null) {
            let iPad = this.pad('00', i, true);
            if (checked && this.checkCheckboxClassChecked(`categoryCheckbox-${iPad}`)) {
                color = defaultColor;
            } else {
                color = partialColor;
            }
            this.changeCheckboxBorderColor(`categoryBacklink-${iPad}`, color);
        } else if (i !== null) {
            let iPad = this.pad('00', i, true);
            color = defaultColor;
            this.changeCheckboxBorderColor(`categoryCheckbox-${iPad}`, color);
            this.changeCheckboxBorderColor(`categoryBacklink-${iPad}`, color);
        } else {
            color = defaultColor;
            this.changeCheckboxBorderColor(`categoryCheckbox`, color);
        }
    },
    checkboxClicked = function(i, j, k, checked)
    {
        let kPad = this.pad('00', k, true);
        if (k !== null) {
            ;
        } else if (j !== null) {
            let iPad = this.pad('00', i, true);
            let jPad = this.pad('00', j, true);
            this.setCheckboxStatusByClass(`categoryCheckbox-${iPad}-${jPad}`, checked);
        } else if (i !== null) {
            let iPad = this.pad('00', i, true);
            this.setCheckboxStatusByClass(`categoryCheckbox-${iPad}`, checked);
        } else {
            this.setCheckboxStatusByClass(`categoryCheckbox`, checked);
        }
        this.backlink(i, j, k, checked);
        this.updateBrands(i);
        this.displayCheckboxProduct('inline');
    },
    displayBrandProducts = function(categoryId, brandId)
    {
        let iPad = this.pad('00', categoryId, true);
        var arr = {};
        var checkboxes = document.getElementsByClassName(`brands-${iPad}`);
        for (let i = 0, j = 0, i_length = checkboxes.length; i < i_length; i++) {
            if (checkboxes[i].checked) {
                var json = JSON.parse(checkboxes[i].value);
                if (typeof arr[json[0]] === "undefined") {
                    arr[json[0]] = {};
                }
                if (typeof arr[json[0]][json[1]] === "undefined") {
                    arr[json[0]][json[1]] = {};
                }
                if (typeof arr[json[0]][json[1]][json[2]] === "undefined") {
                    arr[json[0]][json[1]][json[2]] = {};
                }
            }
        }
        var productIds = [];
        for(index in products) {
            i = products[index]['categoryIds'][0];
            j = products[index]['categoryIds'][1];
            k = products[index]['categoryIds'][2];
            if (
                brandId === products[index]['brandId'] &&
                (typeof arr[i] !== "undefined") &&
                (typeof arr[i][j] !== "undefined") &&
                (typeof arr[i][j][k] !== "undefined")
            ) {
                productIds[index] = index;
            }
        }
        this.generateProductHtml(productIds);
    },
    genMenu = function genMenu()
    {
        var is = {};
        var html = `
            '<div class="displayInlineBlock">
                <div>
                    <span>
                        <div style="float:right;"><input type="checkbox" id="allCategoryCheckbox" checked style="color: #FF0000;" onClick="obj.checkboxClicked(null, null, null, this.checked);"/></div><span><b>Filter&nbsp;::&nbsp;</b></span>
                    </span>
                </div>
            </div>`;
        for(i in categoryHierarchy) {
            is[i] = i;
            iPad = this.pad('00', i, true);
            html += `
            <div class="padl displayInlineBlock">
                <div onmouseleave="obj.hide('subMenu-${iPad}');">
                    <span onmouseenter="obj.displaySubMenu('${iPad}');">
                        <div style="float:left;"><input type="checkbox" checked class="categoryCheckbox categoryBacklink-${iPad}" onClick="obj.checkboxClicked(${i}, null, null, this.checked);"/></div>&nbsp;<span onClick="obj.displayProduct(${i},null,null, true)">${categoryHierarchy[i]['name']}</span>
                    </span>
                    <!-- Sub Menu start-->
                    <div class="subMenu" id="subMenu-${iPad}">`;
            if (typeof categoryHierarchy[i]['subCategory'] !== "undefined") {
                html += `
                        <table width="600" height="200" cellpadding="0" cellspacing="5">
                            <tr>
                                <td class="collapse" width="200" valign="top">
                                    <table width="200" cellpadding="0" cellspacing="2">`;
                for(j in categoryHierarchy[i]['subCategory']) {
                    jPad = this.pad('00', j, true);
                                        html += `
                                        <tr>
                                            <td>
                                                <table width="100%" cellpadding="0" cellspacing="2">
                                                    <tr>
                                                        <td width="17" align="center"><input type="checkbox" checked class="categoryCheckbox categoryCheckbox-${iPad} categoryBacklink-${iPad}-${jPad}" onClick="obj.checkboxClicked(${i}, ${j}, null, this.checked);"/></td>
                                                        <td class="subMenus" align="left" onmouseenter="obj.displaySubSubMenu(${i}, ${j});" onClick="obj.displayProduct(${i}, ${j},null, true)">${categoryHierarchy[i]['subCategory'][j]['name']}</td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>`;
                }
                                    html += `
                                    </table>
                                </td>
                                <td class="collapse" width="400" valign="top">`;
                for(j in categoryHierarchy[i]['subCategory']) {
                    jPad = this.pad('00', j, true);
                                    html += `
                                    <div id="subSubMenu-${iPad}-${jPad}" class="subSubMenu hide">`;
                    if (typeof categoryHierarchy[i]['subCategory'][j]['subCategory'] !== "undefined") {
                                        html += `
                                        <table width="100%" cellpadding="0" cellspacing="2">
                                            <tr>
                                                <td valign="top">
                                                    <table width="100%" cellpadding="0" cellspacing="2">
                                                        <tr>`;
                        for(k in categoryHierarchy[i]['subCategory'][j]['subCategory']) {
                            kPad = this.pad('00', k, true);
                                                html += `
                                                <tr>
                                                    <td>
                                                        <table width="100%" cellpadding="0" cellspacing="2">
                                                            <tr>
                                                                <td width="17" align="center"><input type="checkbox" id="categoryCheckboxId-${iPad}-${jPad}-${kPad}" value="[${i}, ${j}, ${k}]" class="brands-${iPad} categoryCheckbox categoryCheckbox-${iPad} categoryCheckbox-${iPad}-${jPad}" checked onClick="obj.checkboxClicked(${i}, ${j}, ${k}, this.checked);"/></td>
                                                                <td class="subSubMenus" align="left" onClick="obj.displayProduct(${i}, ${j}, ${k}, true)">${categoryHierarchy[i]['subCategory'][j]['subCategory'][k]['name']}</td>
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
                                <td height="27" valign="top" colspan="2" class="collapse brands" id="brands-${iPad}">
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
                <div class="filter">
                    <div style="float:left;"><input type="checkbox" id="searchCheckbox" style="color: #FF0000;"/></div><span onClick="obj.displayCheckboxProduct('search');" class="searchSpan">Search</span>
                </div>
            </div>
            <div class="displayInlineBlock" style="float:right;">
                <input type="text" placeholder="Search.." id="search" onkeyup="filterFunction()">
                <div id="searchResults" style="display:none;">
                    <span>About</span>
                    <span>Base</span>
                    <span>Blog</span>
                    <span>Contact</span>
                    <span>Custom</span>
                    <span>Support</span>
                    <span>Tools</span>
                </div>
            </div>`;

        document.getElementById('menu').innerHTML = html;
        this.displayProduct(null, null, null, false);
        for(index in is) {
            this.updateBrands(index);
        }
    };

    var nsp = {};
    
    nsp.generateCategoryHierarchy = generateCategoryHierarchy;
    nsp.pad = pad;
    nsp.display = display;
    nsp.hide = hide;
    nsp.displaySubMenu = displaySubMenu;
    nsp.displaySubSubMenu = displaySubSubMenu;
    nsp.generateProductHtml = generateProductHtml;
    nsp.displayProduct = displayProduct;
    nsp.checkboxIdChecked = checkboxIdChecked;
    nsp.displayCheckboxProduct = displayCheckboxProduct;
    nsp.updateBrands = updateBrands;
    nsp.setCheckboxStatusByClass = setCheckboxStatusByClass;
    nsp.checkCheckboxClassChecked = checkCheckboxClassChecked;
    nsp.changeCheckboxBorderColor = changeCheckboxBorderColor;
    nsp.backlink = backlink ;
    nsp.checkboxClicked = checkboxClicked;
    nsp.displayBrandProducts = displayBrandProducts;
    nsp.genMenu = genMenu;

    return nsp;
});
