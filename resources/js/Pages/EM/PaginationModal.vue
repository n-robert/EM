<template>
    <nav role="navigation" aria-label="Pagination Navigation" class="flex items-center justify-between">
        <div class="sm:flex-1 sm:flex sm:items-center sm:justify-between">
                <span class="relative inline-flex shadow-sm rounded-md m-auto">

                    <span v-if="pagination.onFirstPage"
                          class="relative inline-flex items-center px-4 py-2 text-sm font-medium text-gray-500 bg-white
                          border border-gray-300 cursor-default leading-5 rounded-md">
                        {{ pagination.previous.label }}
                    </span>

                    <em-button v-else @click.native="openModal(modalId + pagination.previous.label)"
                                  class="relative inline-flex items-center px-4 py-2 text-sm font-medium border
                                  border-gray-300 leading-5 rounded-md focus:outline-none focus:shadow-outline-indigo
                                  focus:border-indigo-300 hover:bg-indigo-500 hover:text-white active:bg-indigo-500
                                  active:text-white transition ease-in-out duration-150">
                        {{ pagination.previous.label }}
                    </em-button>

                    <span v-for="link in pagination.links">
                        <span v-if="link.active || link.url === null" aria-current="page"
                              class="active relative inline-flex items-center px-4 py-2 -ml-px text-sm font-medium
                              border border-gray-300 cursor-default leading-5"
                              :class="[link.active ? [paginationActive] : [paginationNull]]">
                            {{ link.label }}
                        </span>

                        <em-button v-else @click.native="openModal(modalId + link.label)"
                                      class="relative inline-flex items-center px-4 py-2 text-sm font-medium border
                                      border-gray-300 leading-5 rounded-md focus:outline-none focus:shadow-outline-indigo
                                      focus:border-indigo-300 hover:bg-indigo-500 hover:text-white active:bg-indigo-500
                                      active:text-white transition ease-in-out duration-150">
                            {{ link.label }}
                        </em-button>
                    </span>

                    <em-button v-if="pagination.hasPages" @click.native="openModal(modalId + pagination.next.label)"
                                  class="relative inline-flex items-center px-4 py-2 text-sm font-medium border
                                  border-gray-300 leading-5 rounded-md focus:outline-none focus:shadow-outline-indigo
                                  focus:border-indigo-300 hover:bg-indigo-500 hover:text-white active:bg-indigo-500
                                  active:text-white transition ease-in-out duration-150">
                        {{ pagination.next.label }}
                    </em-button>

                    <span v-else
                          class="relative inline-flex items-center px-4 py-2 text-sm font-medium text-gray-500
                          bg-white border border-gray-300 cursor-default leading-5 rounded-md">
                        {{ pagination.next.label }}
                    </span>

                </span>
        </div>
    </nav>
</template>

<script>
import EmButton from './Button';

export default {
    components: {
        EmButton,
    },

    props: [
        'pagination',
        'modalId',
    ],

    inject: [
        'paginationActive',
        'paginationNull',
    ],

    methods: {
        openModal(doc) {
            this.$emit('openModalFromPaginationModal', doc);
        },
    },
};
</script>
