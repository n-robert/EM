<template>
    <app-layout>
        <template #header>
            <centered-item :width="centeredItemWidth">
                <h1 class="font-bold text-indigo-600 text-xl">{{ __(controllerNames.toString().toPhrase()) }}</h1>
            </centered-item>
        </template>

        <centered-item :width="centeredItemWidth">
            <div class="max-w-7xl mx-auto">
                <dropdown
                    v-if="Object.keys(filters).length !== 0"
                    align="left" width="9/12"
                    :buttonCustomClass="customClass"
                    :buttonOpenText="__('Open filters')"
                    :buttonCloseText="__('Close filters')">
                    <template #trigger></template>

                    <template #content>
                        <div v-for="(elements, field) in filters" class="p-2 my-4 border rounded-lg w-full">
                            <div v-if="Object.keys(elements).length > 0" class="font-bold text-indigo-600">
                                {{ field && __(field).ucFirst() }}
                            </div>

                            <div v-for="element in elements" class="inline-flex">
                                <filter-by-field :element="element"></filter-by-field>
                            </div>
                        </div>
                    </template>
                </dropdown>

                <div v-if="pagination.hasPages" class="m-2">
                    <pagination :pagination="pagination"></pagination>
                </div>

                <div class="p-2 m-1 bg-white shadow-xl sm:rounded-lg">
                    <div class="p-2">
                        <div class="text-right text-xs pr-5">
                            {{ pageInfo }}
                        </div>

                        <inertia-link v-if="needAdditionalButton" :href="'/' + controllerName + '/new'"
                                      class="px-4 py-2 border border-gray-300 rounded-md text-white bg-indigo-400
                                      hover:bg-indigo-500">
                            {{ createNewItem }}
                        </inertia-link>
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
                                <div v-if="Object.keys(docList).length" class="p-2 align-top table-cell"></div>
                            </div>
                        </div>

                        <div v-for="item in items" class="even:bg-indigo-100 text-sm table-row-group">
                            <div class="table-row">
                                <div v-for="field in formFields" class="p-2 align-middle table-cell">
                                    <h2 v-if="field.name === 'default_name'"
                                        class="pl-6 py-1 text-indigo-800 hover:text-indigo-500 text-left">
                                        <inertia-link :href="'/' + controllerName + '/' + item.id">
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

                                <form v-if="$page.props.canEdit"
                                      :id="'delete-' + item.id"
                                      @submit.prevent="deleteItem(item)"
                                      class="p-2 align-middle table-cell">
                                    <e-m-button class="hover:text-white hover:bg-indigo-500">
                                        {{ __('Delete') }}
                                    </e-m-button>
                                </form>

                                <div v-if="Object.keys(docList).length"
                                     class="p-2 align-middle table-cell">
                                    <e-m-button :type="'button'"
                                                class="hover:text-white hover:bg-indigo-500"
                                                @click.native="openModalFromItems(item.id)">
                                        {{ __('Print documents') }}
                                    </e-m-button>
                                </div>

                                <dialog-modal v-if="modal[item.id]" :show="modal[item.id]" :id="item.id"
                                              @closeModalFromDialog="closeModalFromItems">
                                    <template #content>
                                        <doc-list :modal="modal" :item="item" :docList="docList"
                                                  @openModalFromDocList="openModalFromItems"
                                                  @closeModalFromDocList="closeModalFromItems"
                                                  @addFieldStateFromDocList="addFieldToDocList"/>
                                    </template>
                                </dialog-modal>
                            </div>
                        </div>
                    </div>

                    <div class="p-2">
                        <inertia-link :href="'/' + controllerName + '/new'"
                                      class="px-4 py-2 border border-gray-300 rounded-md text-white bg-indigo-400
                                      hover:bg-indigo-500">
                            {{ createNewItem }}
                        </inertia-link>

                        <div class="text-right text-xs pr-5">
                            {{ pageInfo }}
                        </div>
                    </div>
                </div>
            </div>

            <div v-if="pagination.hasPages" class="p-2">
                <pagination :pagination="pagination"></pagination>
            </div>
        </centered-item>
    </app-layout>
</template>

<script>
import AppLayout from '../../Layouts/AppLayout';
import EMButton from './Button';
import CenteredItem from './CenteredItem';
import DialogModal from './DialogModal';
import DocList from './DocList';
import Pagination from './Pagination';
import FilterByField from './FilterByField';
import Dropdown from './Dropdown';

export default {
    components: {
        AppLayout,
        EMButton,
        CenteredItem,
        DialogModal,
        DocList,
        Pagination,
        FilterByField,
        Dropdown,
    },

    props: [
        'items',
        'filters',
        'hasFilters',
        'pagination',
        'modal',
        'docList',
        'formFields',
        'controllerName',
        'controllerNames',
    ],

    provide() {
        return {
            controllerName: this.controllerName,
            controllerNames: this.controllerNames,
        };
    },

    data() {
        return {
            centeredItemWidth: {
                md: 'full',
                xl: '3/4',
            },
            needAdditionalButton: this.items.length > 7,
            createNewItem: this.__('New ' + this.controllerName),
            itemCount: [
                this.pagination.firstItem + '-' + this.pagination.lastItem,
                this.__('from'),
                this.pagination.total
            ].join(' '),
        };
    },

    computed: {
        customClass: function () {
            return 'inline-flex hover:text-white' + (
                this.hasFilters ?
                    ' bg-indigo-400 text-white hover:bg-indigo-500' : ' bg-white text-gray-500 hover:bg-indigo-500'
            );
        },

        pageInfo: function () {
            return this.pagination.total ?
                [
                    this.pagination.firstItem + '-' + this.pagination.lastItem,
                    this.__('from'),
                    this.pagination.total
                ].join(' ') : '';
        },
    },

    methods: {
        deleteItem(item) {
            const
                form = document.getElementById('delete-' + item.id),
                confirm =
                    window.confirm(
                        this.__(
                            'This action will permanently delete ":account" from database. Are you sure?',
                            {account: item.default_name},
                        ),
                    );

            let formData = new FormData(form);

            formData.append('id', item.id);

            confirm && this.$inertia.post('/' + this.controllerName + '/delete', formData);
        },

        openModalFromItems(doc) {
            this.modal[doc] = true;
        },

        closeModalFromItems(doc) {
            this.modal[doc] = false;
        },

        addFieldToDocList(doc, id) {
            this.docList[doc][id] = true;
        },
    },
};
</script>
