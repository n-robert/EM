<template>
    <centered-item v-if="dataLoaded" :width="centeredItemWidth">
        <div class="max-w-7xl mx-auto">
            <div class="p-2 m-1 bg-white shadow-xl sm:rounded-lg">
                <div class="p-2">
                    <div class="text-right text-xs pr-5">
                        {{ pageInfo }}
                    </div>
                </div>

                <div class="p-4 table w-full">
                    <div class="even:bg-indigo-100 text-indigo-600 table-row-group font-bold">
                        <div class="table-row">
                            <div v-for="field in formFields" class="p-2 align-top table-cell">
                                <div v-if="field.name === 'default_name'" class="pl-6 text-left">
                                    {{ field.label && __(field.label).ucFirst() }}
                                </div>

                                <div v-else>{{ field.label && __(field.label).ucFirst() }}</div>
                            </div>

                            <div class="p-2 align-middletop table-cell"></div>
                        </div>
                    </div>

                    <div v-for="item in items" class="even:bg-indigo-100 text-sm table-row-group">
                        <div class="table-row">
                            <div v-for="field in formFields" class="p-2 align-middle table-cell">
                                <h2 v-if="field.name === 'default_name'"
                                    class="pl-6 py-1 font-bold text-indigo-500 hover:text-indigo-700 text-left">
                                    <inertia-link
                                        :href="item.item_custom_link || '/' + controllerName + '/' + item.id">
                                        {{ item.default_name }}
                                    </inertia-link>
                                </h2>

                                <div v-else>
                                    {{
                                        field.name && field.name.endsWith('_date') ?
                                            formatDate(item[field.name]) : __(item[field.name])
                                    }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="p-2">
                    <div class="text-right text-xs pr-5">
                        {{ pageInfo }}
                    </div>
                </div>
            </div>
        </div>
    </centered-item>
</template>

<script>
import CenteredItem from './CenteredItem';
import Pagination from './PaginationModal';
import DialogModal from './DialogModal';

export default {
    components: {
        CenteredItem,
        Pagination,
        DialogModal,
    },

    props: {
        itemCustomLink: {
            default: null,
        },
        modalId: {
            default: null,
        },
        modal: {
            default: null,
        },
    },

    data() {
        return {
            page: this.$page,
            items: null,
            pagination: null,
            formFields: null,
            controllerName: null,
            controllerNames: null,
            centeredItemWidth: {
                md: 'full',
                xl: '10/12',
            },
            pageInfo: null,
            dataLoaded: false,
        };
    },

    mounted() {
        const axios = require('axios');

        axios.post(this.itemCustomLink).then(response => {
            this.items = response.data.items;
            this.pagination = response.data.pagination;
            this.formFields = response.data.formFields;
            this.controllerName = response.data.controllerName;
            this.controllerNames = response.data.controllerNames;
            this.pageInfo = this.pagination ?
                [
                    this.pagination.firstItem + '-' + this.pagination.lastItem,
                    this.__('from'),
                    this.pagination.total
                ].join(' ') : '';
        }).then(() => {
            this.dataLoaded = true;
        });
    },
};
</script>
