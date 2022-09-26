<template>
    <div class="space-y-4 pb-2 text-center mx-auto" :class="widthClass">
        <slot></slot>
    </div>
</template>

<script>
export default {
    props: {
        width: {
            default: {def: 'auto'},
        }
    },

    computed: {
        widthClass() {
            let widthClass = [];

            Object.keys(this.width).map(key => {
                widthClass.push((key + ':').replace('def:', '') + 'w-' + this.width[key]);
            });

            return widthClass.join(' ');
        },
    },
};
</script>
