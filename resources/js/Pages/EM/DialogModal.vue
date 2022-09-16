<template>
    <modal :show="show" :max-width="maxWidth" :closeable="closeable" @close="closeModal">
        <div class="px-6 py-4">
            <e-m-button class="relative float-right cursor-pointer m-1" @click.native="closeModal">X</e-m-button>

            <div v-if="this.$slots.title" class="text-lg">
                <slot name="title"></slot>
            </div>

            <slot name="content"></slot>
        </div>

        <div v-if="this.$slots.footer" class="px-6 py-4 bg-gray-100 text-right">
            <slot name="footer"></slot>
        </div>
    </modal>
</template>

<script>
    import EMButton from './Button';
    import Modal from './Modal';

    export default {
        components: {
            EMButton,
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
