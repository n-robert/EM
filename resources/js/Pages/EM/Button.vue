<template>
    <button :type="type"
            :class="[defaultClass, customClass]"
            :onclick="onclick">
        <slot>{{open ? alternativeText || originalText : originalText}}</slot>
    </button>
</template>

<script>
    export default {
        props: {
            type: {
                type: String,
                default: 'submit',
            },
            customClass: {
                default: '',
            },
            id: {
                default: null,
            },
            originalText: {
                default: null,
            },
            alternativeText: {
                default: null,
            },
            onclick: {
                default: 'this.blur();',
            },
            open: {
                default: false,
            },
        },

        data()
        {
            return {
                defaultClass: 'items-center px-2 py-1 border border-gray-300 rounded-md transition ease-in-out duration-150',
            }
        },
    };
</script>
