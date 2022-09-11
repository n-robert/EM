<template>
    <div class="relative m-2">
        <div @click="open = ! open" :class="{'relative z-50': open}" class="w-48 text-left">
            <slot name="trigger"></slot>
            <e-m-button :type="'button'"
                        :open="open"
                        :originalText="buttonOpenText"
                        :alternativeText="buttonCloseText"
                        :customClass="buttonCustomClass">
            </e-m-button>
        </div>

        <!-- Full Screen Dropdown Overlay -->
        <div v-show="open" class="fixed inset-0 z-40 bg-gray-500 opacity-75" @click="open = false">
        </div>

        <transition
                enter-active-class="transition ease-out duration-200"
                enter-class="transform opacity-0 scale-95"
                enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75"
                leave-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95">
            <div v-show="open"
                 class="absolute z-50 mt-2 rounded-md shadow-lg"
                 :class="[widthClass, alignmentClasses]"
                 style="display: none;">
                <div class="rounded-md shadow-xs" :class="contentClasses">
                    <slot name="content"></slot>
                </div>
            </div>
        </transition>
    </div>
</template>

<script>
    import EMButton from './Button';

    export default {
        components: {
            EMButton,
        },

        props: {
            align: {
                default: 'right',
            },
            width: {
                default: '48',
            },
            contentClasses: {
                default: () => ['py-2', 'px-6', 'mb-4', 'bg-white'],
            },
            buttonCustomClass: {
                default: '',
            },
            buttonOpenText: {
                default: '',
            },
            buttonCloseText: {
                default: '',
            },
        },

        data()
        {
            return {
                open: false,
            };
        },

        created()
        {
            const closeOnEscape = (e) => {
                if (this.open && e.keyCode === 27) {
                    this.open = false;
                }
            };

            this.$once('hook:destroyed', () => {
                document.removeEventListener('keydown', closeOnEscape);
            });

            document.addEventListener('keydown', closeOnEscape);
        },

        computed: {
            widthClass()
            {
                return {
                    'auto': 'w-auto',
                    'screen': 'w-screen',
                    'full': 'w-full',
                    'max': 'w-max',
                    '6/12': 'w-6/12',
                    '9/12': 'w-9/12',
                    '48': 'w-48',
                }[this.width.toString()];
            },

            alignmentClasses()
            {
                if (this.align === 'left') {
                    return 'origin-top-left left-0';
                } else
                    if (this.align === 'right') {
                        return 'origin-top-right right-0';
                    } else {
                        return 'origin-top';
                    }
            },
        },
    };
</script>
