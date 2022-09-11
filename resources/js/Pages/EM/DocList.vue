<template>
    <div>
        <div v-for="(state, doc) in docList" class="pl-10 py-1">
            <e-m-button :type="'button'"
                        @click.native="openModal(doc)"
                        class="hover:text-white hover:bg-indigo-500">
                {{__(doc.toPhrase())}}
            </e-m-button>
        </div>

        <div v-for="(state, doc) in docList">
            <dialog-modal v-if="modal[doc] || state[item.id]" :show="modal[doc]" :id="doc"
                          @closeModalFromDialog="closeModal">
                <template #content>
                    <doc-form :name="doc.toKebabCase()"
                              :item="item"
                              :modal="modal"
                              :leftColumn="leftColumn"
                              :rightColumn="rightColumn"
                              @openModalFromDocForm="openModal"
                              @closeModalFromDocForm="closeModal"
                              @addFieldStateFromDocForm="addFieldToDocList">
                        <template #submit>
                            <div class="table-row">
                                <div>
                                    <div>
                                        <span :class="leftColumn"></span>

                                        <span :class="rightColumn">
                                            <e-m-button :type="'button'"
                                                        class="mr-6 hover:text-white hover:bg-indigo-500"
                                                        @click.native="closeModal(doc)">{{__('Cancel')}}</e-m-button>

                                            <e-m-button :type="'submit'" class="hover:text-white hover:bg-indigo-500">
                                                {{__('Print')}}
                                            </e-m-button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </template>
                    </doc-form>
                </template>
            </dialog-modal>
        </div>
    </div>
</template>

<script>
    const
        components = {
            EMButton: () => import('./Button'),
            DialogModal: () => import('./DialogModal'),
            DocForm: () => import('./DocForm'),
        };

    export default {
        components: components,

        inject: [
            'leftColumn',
            'rightColumn',
        ],

        props: [
            'modal',
            'item',
            'docList',
        ],

        methods: {
            openModal(doc) {
                this.$emit('openModalFromDocList', doc);
            },

            closeModal(doc) {
                this.$emit('closeModalFromDocList', doc);
            },

            addFieldToDocList(doc, id) {
                this.$emit('addFieldStateFromDocList', doc, id);
            },
        },
    };
</script>
