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
                    v-if="Object.keys(filters).length"
                    align="left" width="10/12"
                    :buttonCustomClass="customClass"
                    :buttonOpenText="__('Open filters')"
                    :buttonCloseText="__('Close filters')">
                    <template #trigger></template>

                    <template #content>
                        <div v-for="(elements, field) in filters" class="p-2 my-4 border rounded-lg w-full">
                            <div v-if="!(Object.keys(elements).length === 1 && elements[field])"
                                 class="font-bold text-indigo-600">
                                {{ field && __(field).ucFirst() }}
                            </div>

                            <div v-for="element in elements" class="inline-flex">
                                <filter-by-field :element="element"></filter-by-field>
                            </div>
                        </div>
                    </template>
                </dropdown>

                <dialog-modal v-if="showVisaExtensionReminder && modal['visaExtensionReminder']"
                              :show="showVisaExtensionReminder"
                              :id="'visaExtensionReminder'">
                    <template #content>
                        <div class="text-indigo-500">
                            <pre>{{ visaExtensionReminder }}</pre>

                            <div class="mt-4 text-center mx-auto">
                                <em-button :type="'button'"
                                           class="mt-4 font-bold hover:text-white hover:bg-indigo-500"
                                           @click.native="closeModal([
                                               'visaExtensionReminder',
                                               true,
                                           ])">
                                    {{ __("Don't show this any more") }}
                                </em-button>
                            </div>
                        </div>
                    </template>
                </dialog-modal>

                <div v-if="pagination.hasPages" class="mx-1 mt-2">
                    <pagination :pagination="pagination"></pagination>
                </div>

                <div class="p-2 mx-1 mt-2 bg-white shadow-xl sm:rounded-lg">
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

                    <div class="p-4 sm:px-0 table w-full">
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
                                <div v-for="field in formFields" class="p-2 sm:px-0 align-middle table-cell">
                                    <em-button v-if="field.is_button"
                                               class="min-w-max w-1/5
                                               font-bold text-indigo-500 hover:text-white hover:bg-indigo-500"
                                               @click.native="buttonTarget(field, item)">
                                        {{ __(item[field.name]) }}
                                    </em-button>

                                    <h2 v-else-if="field.name === 'default_name'" class="pl-6 py-1 text-left">
                                        <inertia-link
                                            v-if="field.is_link"
                                            :href="itemLink(item)"
                                            class="font-bold text-indigo-500 hover:text-indigo-700">
                                            {{ item.default_name }}
                                        </inertia-link>

                                        <span v-else>{{ item.default_name }}</span>
                                    </h2>

                                    <div v-else>
                                        {{
                                            field.name && field.name.endsWith('_date') ?
                                                formatDate(item[field.name]) : __(item[field.name])
                                        }}
                                    </div>
                                </div>

                                <div v-if="$page.props.isAdmin" class="p-2 align-middle table-cell">
                                    <form v-if="!item.no_edit_link"
                                          :id="'delete-' + item.id"
                                          @submit.prevent="deleteItem(item)">
                                        <em-button
                                            class="font-bold text-indigo-500 hover:text-white hover:bg-indigo-500">
                                            {{ __('Delete') }}
                                        </em-button>
                                    </form>
                                </div>

                                <div v-if="Object.keys(docList).length"
                                     class="p-2 align-middle table-cell">
                                    <em-button :type="'button'"
                                               class="font-bold text-indigo-500 hover:text-white hover:bg-indigo-500"
                                               @click.native="openModal(item.id)">
                                        {{ __('Print documents') }}
                                    </em-button>
                                </div>

                                <div v-if="hasModal(item)">
                                    <dialog-modal
                                        v-if="!item.item_custom_link"
                                        :show="hasModal(item)"
                                        :id="modalId(item)"
                                        :position="'absolute'">
                                        <template #content>
                                            <doc-list v-if="Object.keys(docList).length"
                                                      :modal="modal"
                                                      :item="item"
                                                      :docList="docList">
                                            </doc-list>
                                        </template>
                                    </dialog-modal>

                                    <dialog-modal v-else-if="item.modal_items_count"
                                                  :show="hasModal(item)"
                                                  :id="modalId(item)"
                                                  :position="'absolute'">
                                        <template #content>
                                            <div v-for="k in item.modal_items_count">
                                                <items-modal v-if="k === 1"
                                                             :itemCustomLink="item.item_custom_link"
                                                             :modalId="modalId(item)">
                                                </items-modal>

                                                <items-modal v-else
                                                             :itemCustomLink="item.item_custom_link + '?page=' + k"
                                                             :modalId="modalId(item)">
                                                </items-modal>
                                            </div>
                                        </template>
                                    </dialog-modal>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="p-2">
                        <inertia-link v-if="canCreateNewItem" :href="'/' + controllerName + '/new'"
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

            <div class="text-right">
                <em-button :type="'button'"
                           class="font-bold text-indigo-500 hover:text-white hover:bg-indigo-500"
                           @click.native="printPage()">
                    {{ __('Print page') }}
                </em-button>
            </div>
        </centered-item>
    </app-layout>
</template>

<script>
import AppLayout from './AppLayout';
import EmButton from './Button';
import CenteredItem from './CenteredItem';
import DialogModal from './DialogModal';
import DocList from './DocList';
import Pagination from './Pagination';
import FilterByField from './FilterByField';
import Dropdown from './Dropdown';
import ItemsModal from './ItemsModal';

export default {
    components: {
        AppLayout,
        EmButton,
        CenteredItem,
        DialogModal,
        DocList,
        Pagination,
        FilterByField,
        Dropdown,
        ItemsModal,
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
        'canCreateNewItem',
        'visaExtensionReminder',
    ],

    provide() {
        return {
            controllerName: this.controllerName,
            controllerNames: this.controllerNames,
        };
    },

    data() {
        this.visaExtensionReminder && (
            $cookies.isKey('visaExtensionReminder')
            || $cookies.set('visaExtensionReminder', true)
        );
        return {
            centeredItemWidth: {
                md: 'full',
                xl: '10/12',
            },
            needAdditionalButton: this.canCreateNewItem && this.items.length > 5,
            createNewItem: this.__('New ' + this.controllerName),
            showVisaExtensionReminder: $cookies.get('visaExtensionReminder') === 'true',
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

    mounted() {
        this.$root.$on('openModal', (id) => {
            this.modal[id] = true;
        });

        this.$root.$on('closeModal', (data) => {
            const id = data[0], noCookie = data[1] || null;
            this.modal[id] = !this.modal[id] || false;
            noCookie && $cookies.isKey(id) && $cookies.set(id, false);
        });
    },

    methods: {
        itemLink(item) {
            return item.item_custom_link || '/' + this.controllerName + '/' + item.id;
        },

        hasModal(item) {
            return this.modal[item.id] || this.modal[item.default_name];
        },

        modalId(item) {
            return item.id || item.default_name;
        },

        buttonTarget(field, item) {
            return (
                    field.open_modal && this.openModal(item.default_name))
                || (field.is_link && this.visit(this.itemLink(item))
                );
        },

        deleteItem(item) {
            const
                form = this.$root.$el.querySelector('#delete-' + item.id),
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

        openModal(doc) {
            this.$root.$emit('openModal', doc);
        },

        closeModal(data) {
            this.$root.$emit('closeModal', data);
        },

        visit(url) {
            this.$inertia.visit(url);
        },

        printPage() {
            window.print();
        }
    },
};
</script>
