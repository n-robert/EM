<template>
    <app-layout>
        <template #header>
            <centered-item :width="centeredItemWidth">
                <div class="font-bold text-indigo-600">{{__(controllerNames.toString().toPhrase())}}</div>
            </centered-item>
        </template>

        <centered-item :width="centeredItemWidth">
            <div class="max-w-7xl mx-auto">
                <dropdown v-if="filters.length !== 0" align="left" width="9/12" :buttonCustomClass="buttonCustomClass">
                    <template #trigger></template>

                    <template #content>
                        <div v-for="(elements, field) in filters" class="p-2 my-4 border rounded-lg w-full">
                            <div class="font-bold">{{__(field)}}</div>

                            <div v-for="element in elements" class="inline-flex">
                                <filter-by-field :element="element"></filter-by-field>
                            </div>
                        </div>
                    </template>
                </dropdown>

                <div v-if="pagination.hasPages" class="py-2">
                    <pagination :pagination="pagination"></pagination>
                </div>

                <div class="p-2 bg-white shadow-xl sm:rounded-lg">
                    <div class="p-2 mt-3">
                        <inertia-link v-if="pagination.hasPages" :href="'/' + controllerName + '/new'"
                                      class="px-4 py-2 border border-gray-300 rounded-md text-white bg-indigo-400
                                      hover:text-white hover:bg-indigo-600">
                            {{__('New ' + controllerName)}}
                        </inertia-link>
                    </div>

                    <div class="p-4 table w-full">
                        <div v-for="item in items" class="even:bg-gray-200 table-row-group">
                            <div class="table-row">
                                <inertia-link :href="'/' + controllerName + '/' + item.id"
                                              class="p-2 hover:text-indigo-500">
                                    <h1 class="mr-4 table-cell">{{getDefaultName(item)}}</h1>
                                </inertia-link>

                                <form v-if="$page.props.canEdit" :id="'delete-' + item.id"
                                      @submit.prevent="deleteItem(item)"
                                      class="p-2 table-cell">
                                    <fmsdocs-button>{{__('Delete')}}</fmsdocs-button>
                                </form>

                                <fmsdocs-button v-if="Object.keys(docList).length" :type="'button'"
                                                @click.native="openModalFromItems(item.id)"
                                                class="p-2 table-cell">
                                    {{__('Print documents')}}
                                </fmsdocs-button>

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
                                      hover:text-white hover:bg-indigo-600">
                            {{__('New ' + controllerName)}}
                        </inertia-link>
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
    import FmsdocsButton from './Button';
    import CenteredItem from './CenteredItem';
    import DialogModal from './DialogModal';
    import DocList from './DocList';
    import Pagination from './Pagination';
    import FilterByField from './FilterByField';
    import Dropdown from './Dropdown';

    export default {
        components: {
            AppLayout,
            FmsdocsButton,
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
            'pagination',
            'modal',
            'docList',
            'controllerName',
            'controllerNames',
        ],

        provide()
        {
            return {
                controllerName: this.controllerName,
                controllerNames: this.controllerNames,
            };
        },

        data()
        {
            return {
                centeredItemWidth: {
                    md: 'full',
                    xl: '3/4',
                },
                buttonCustomClass: 'inline-flex text-white bg-indigo-400 hover:text-white hover:bg-indigo-600',
            };
        },

        methods: {
            getDefaultName(item)
            {
                return (this.controllerName === 'employee') ? item.full_name_ru : item.default_name;
            },

            deleteItem(item)
            {
                const
                    form = document.getElementById('delete-' + item.id),
                    confirm =
                        window.confirm(
                            this.__(
                                'This action will permanently delete ":account" from database. Are you sure?',
                                {account: this.getDefaultName(item)},
                            ),
                        );

                let formData = new FormData(form);

                formData.append('id', item.id);

                confirm && this.$inertia.post('/' + this.controllerName + '/delete', formData);
            },

            openModalFromItems(doc)
            {
                this.modal[doc] = true;
            },

            closeModalFromItems(doc)
            {
                this.modal[doc] = false;
            },

            addFieldToDocList(doc, id)
            {
                this.docList[doc][id] = true;
            },
        },
    };
</script>