<template>
    <portal to="modal">
        <transition leave-active-class="duration-200">
            <div v-show="show" :class="[position, topScroll]" class="inset-x-0 px-4 py-6 sm:px-0 sm:flex sm:items-top sm:justify-center">
                <transition enter-active-class="ease-out duration-300"
                            enter-class="opacity-0"
                            enter-to-class="opacity-100"
                            leave-active-class="ease-in duration-200"
                            leave-class="opacity-100"
                            leave-to-class="opacity-0">
                    <div v-show="show" class="fixed inset-0 transform transition-all" @click="close">
                        <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
                    </div>
                </transition>

                <transition enter-active-class="ease-out duration-300"
                            enter-class="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                            enter-to-class="opacity-100 translate-y-0 sm:scale-100"
                            leave-active-class="ease-in duration-200"
                            leave-class="opacity-100 translate-y-0 sm:scale-100"
                            leave-to-class="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
                    <div v-show="show" class="bg-white rounded-lg shadow-xl transform transition-all sm:w-full mx-8"
                         :class="maxWidthClass">
                        <slot></slot>
                    </div>
                </transition>
            </div>
        </transition>
    </portal>
</template>

<script>
export default {
    props: {
        show: {
            default: false,
        },
        maxWidth: {
            default: '4xl',
        },
        closeable: {
            default: true,
        },
        position: {
            default: 'fixed',
        },
    },

    data() {
        let rate = window.scrollY/window.innerHeight;

        switch (true) {
            case rate > 0.84:
                rate = 'full';
                break;
            case  rate > 0.7:
                rate = '3/4';
                break;
            case rate > 0.56:
                rate = '2/3';
                break;
            case rate > 0.42:
                rate = '1/2';
                break;
            case rate > 0.28:
                rate = '1/3';
                break;
            case rate > 0.14:
                rate = '1/4';
                break;
            default:
                rate = '0';
        }

        return {
            topScroll: 'top-' + rate
        };
    },

    mounted() {
        this.$nextTick(() => {
            window.addEventListener('resize', this.onResize);
        });
    },

    beforeDestroy() {
        window.removeEventListener('resize', this.onResize);
    },

    methods: {
        close() {
            if (this.closeable) {
                this.$emit('close');
            }
        },

        onResize() {
            this.windowHeight = window.innerHeight
        },
    },

//        watch: {
//            show: {
//                deep: true,
//                handler: show => {
//                    if (show) {
//                        document.body.style.overflow = 'hidden';
//                    } else {
//                        document.body.style.overflow = null;
//                    }
//                },
//            },
//        },

    created() {
        const closeOnEscape = (e) => {
            if (e.key === 'Escape' && this.show) {
                this.close();
            }
        };

        document.addEventListener('keydown', closeOnEscape);

        this.$once('hook:destroyed', () => {
            document.removeEventListener('keydown', closeOnEscape);
        });
    },

    computed: {
        maxWidthClass() {
            return {
                'sm': 'sm:max-w-sm',
                'md': 'sm:max-w-md',
                'lg': 'sm:max-w-lg',
                'xl': 'sm:max-w-xl',
                '2xl': 'sm:max-w-2xl',
                '3xl': 'sm:max-w-3xl',
                '4xl': 'sm:max-w-4xl',
                'full': 'sm:max-w-full',
            }[this.maxWidth];
        },
    },
};
</script>
