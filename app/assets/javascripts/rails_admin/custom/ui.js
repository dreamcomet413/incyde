$(document).on('rails_admin.dom_ready', function(){

    /* Viveros */
    loadNestedCitySelects('#business_incubator_business_incubator_profile_attributes_country_id',
        '#business_incubator_business_incubator_profile_attributes_region_id', '/regions');

    loadNestedCitySelects('#business_incubator_business_incubator_profile_attributes_region_id',
        '#business_incubator_business_incubator_profile_attributes_province_id', '/provinces');

    loadNestedCitySelects('#business_incubator_business_incubator_profile_attributes_province_id',
        '#business_incubator_business_incubator_profile_attributes_city_id', '/cities');

    /* Viveristas */
    loadNestedCitySelects('#company_company_profile_attributes_country_id',
        '#company_company_profile_attributes_region_id', '/regions');

    loadNestedCitySelects('#company_company_profile_attributes_region_id',
        '#company_company_profile_attributes_province_id', '/provinces');

    loadNestedCitySelects('#company_company_profile_attributes_province_id',
        '#company_company_profile_attributes_city_id', '/cities');

    function loadNestedCitySelects(select_id, nested_select_id, path){
        $(select_id).on('change', function(){
            var options = $.getJSON('/city_selects/'+$(this).val()+path).done(function() {
                var select = $(nested_select_id);
                var elements = [];
                $.each(options.responseJSON, function (a, option) {
                    elements.push($("<option></option>").attr("value", option.id).text(option.name))
                })
                select.parent().find('.filtering-select').hide();
                select.filteringSelect("destroy").find("option:gt(0)").remove().end().append(elements).filteringSelect().val(select);

            });
        })
    }

});

