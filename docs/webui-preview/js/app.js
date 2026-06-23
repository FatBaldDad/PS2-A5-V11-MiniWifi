const menuButtons = Array.from(document.querySelectorAll(".menu-item"));
const views = Array.from(document.querySelectorAll("[data-view]"));

function showView(targetId) {
	for (const view of views) {
		const shouldShow = view.id === targetId;
		view.classList.toggle("is-visible", shouldShow);
		view.hidden = !shouldShow;
	}

	for (const button of menuButtons) {
		const isActive = button.dataset.target === targetId;
		button.classList.toggle("is-active", isActive);
		button.setAttribute("aria-current", isActive ? "page" : "false");
	}
}

for (const button of menuButtons) {
	button.addEventListener("click", () => {
		showView(button.dataset.target);
	});
}

showView("dashboard");
console.log("PS2 A5-V11 MiniWifi WebUI mockup loaded.");
