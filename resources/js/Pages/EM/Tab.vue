<template>
    <div v-show="isActive" class="table-row-group">
        <slot></slot>
    </div>
</template>

<script>
    export default {
        props: {
            selected: {default: false},
        },
        computed: {
           isActive: function () {
               return this.selected;
           }
        },
    };
</script>