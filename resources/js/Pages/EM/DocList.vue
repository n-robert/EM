<template>
    <div>
        <div v-for="(state, doc) in docList" class="pl-10 py-1">
            <em-button :type="'button'"
                        @click.native="openModal(doc)"
                        class="hover:text-white hover:bg-indigo-500">
                {{ __(doc.toPhrase()) }}
            </em-button>
        </div>

        <div v-for="(state, doc) in docList">
            <dialog-modal v-if="modal[doc]"
                          :show="modal[doc]"
                          :id="doc"
                          :position="'absolute'">
                <template #content>
                    <doc-form :name="doc.toKebabCase()"
                              :item="item"
                              :modal="modal"
                              :leftColumn="leftColumn"
                              :rightColumn="rightColumn">
                        <template #submit>
                            <div class="table-row">
                                <div>
                                    <div>
                                        <span :class="leftColumn"></span>

                                        <span :class="rightColumn">
                                            <em-button :type="'button'"
                                                        class="mr-6 hover:text-white hover:bg-indigo-500"
                                                        @click.native="closeModal([doc])">
                                                {{ __('Cancel') }}
                                            </em-button>

                                            <em-button :type="'submit'" class="hover:text-white hover:bg-indigo-500">
                                                {{ __('Print') }}
                                            </em-button>
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
        EmButton: () => import('./Button'),
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
            this.$root.$emit('openModal', doc);
        },

        closeModal(data) {
            this.$root.$emit('closeModal', data);
        },
    },
};
</script>
