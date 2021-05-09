<template>
    <modal :show="show" :max-width="maxWidth" :closeable="closeable" @close="closeModal">
        <div class="px-6 py-4">
            <fmsdocs-button class="relative float-right cursor-pointer m-2" @click.native="closeModal">X</fmsdocs-button>

            <div v-if="this.$slots.title" class="text-lg">
                <slot name="title"></slot>
            </div>

            <div class="mt-4">
                <slot name="content"></slot>
            </div>
        </div>

        <div v-if="this.$slots.footer" class="px-6 py-4 bg-gray-100 text-right">
            <slot name="footer"></slot>
        </div>
    </modal>
</template>

<script>
    import FmsdocsButton from './Button';
    import Modal from './Modal';

    export default {
        components: {
            FmsdocsButton,
            Modal,
        },

        props: {
            show: {
                default: false,
            },
            maxWidth: {
                default: '2xl',
            },
            closeable: {
                default: true,
            },
            id: {
                default: null,
            },
        },

        methods: {
            closeModal()
            {
                this.$emit('closeModalFromDialog', this.id);
            },
        },
    };
</script>
