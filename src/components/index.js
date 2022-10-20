import MyLoading from "@/components/MyLoading.vue";
import TasteSelection from "@/components/TasteSelection.vue";
import CartList from "@/components/CartList.vue";
export default {
  install(app) {
    app
      .component("MyLoading", MyLoading)
      .component("TasteSelection", TasteSelection)
      .component("CartList", CartList);
  },
};
