<template>
    <button :type="type" :class="[defaultClass, customClass]" :onclick="onclick">
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
                defaultClass: 'items-center m-1 px-2 py-1 border rounded-md hover:bg-indigo-600 hover:text-white transition ease-in-out duration-150',
            }
        },
    };
</script>
