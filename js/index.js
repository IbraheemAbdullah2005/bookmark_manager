const linkBarTemplate = await fetch("../template/linkBar.html");
const linkBar = await linkBarTemplate.text();

const data = await fetch("../php/get_bookmarks.php");
const dataObj = await data.json();

document.getElementById("totalBookmarks").innerHTML = dataObj.length;

const replaceTemplate = (temp, link) => {
  let output = temp.replace(/{%NAME%}/g, link.name);
  output = output.replace(/{%URL%}/g, link.url);
  output = output.replace(/{%IMAGE%}/g, link.image);
  output = output.replace(/{%ID%}/g, link.id);

  return output;
};

const linkHTML = dataObj.map((el) => replaceTemplate(linkBar, el)).join("");

const linkSection = document.querySelector(".links-section");
linkSection.innerHTML = linkHTML;

const desc = document.getElementById("description");
const linkButtons = document.querySelectorAll(".btn-link");

linkButtons.forEach((button) => {
  button.addEventListener("click", () => {
    desc.classList.remove("hidden");
  });
});

const closeButton = document.getElementById("close-btn");
closeButton.addEventListener("click", () => {
  desc.classList.add("hidden");
});

window.showDetails = async function (id) {
  try {
    const response = await fetch(`../php/get_details.php?id=${id}`);
    const data = await response.json();
    const tagsHTML = data.tags
      ? data.tags
          .split(",")
          .map((tag) => `<li class="desc-tag">${tag.trim()}</li>`)
          .join("")
      : "";

    const temp = `
        <img src="${data.image}" class="desc-img" />
        <h2 class="desc-header">${data.name}</h2>
        <a class="desc-link" href="${data.url}" target="_blank">${data.url}</a>
        
        <p class="desc-desc">${data.description || "No description provided."}</p>
        
        <ul class="desc-tags">
            ${tagsHTML}
        </ul>
        
        <p class="desc-date">Added on ${data.created_at}</p>
        ${data.updated_at ? `<p class="desc-date">Updated on ${data.updated_at}</p>` : ""}
        
        <div class="desc-actions">
          <button class="desc-action" onclick="editBookmark(${data.id})">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-square-pen"><path d="M12 3H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.375 2.625a1 1 0 0 1 3 3l-9.013 9.014a2 2 0 0 1-.853.505l-2.873.84a.5.5 0 0 1-.62-.62l.84-2.873a2 2 0 0 1 .506-.852z"/></svg>
            <span>Edit</span>
          </button>
          
          <button id="delete-btn" class="desc-action" onclick="deleteBookmark(${data.id})">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash"><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"/><path d="M3 6h18"/><path d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
            <span>Delete</span>
          </button>
        </div>`;

    const addContent = document.getElementById("addContent");
    addContent.innerHTML = temp;
  } catch (error) {
    console.error("Error fetching details:", error);
  }
};

window.deleteBookmark = async function (id) {
  if (!confirm("Are you sure you want to delete this bookmark?")) {
    return;
  }

  const formData = new FormData();
  formData.append("id", id);

  try {
    const response = await fetch("../php/delete_bookmark.php", {
      method: "POST",
      body: formData,
    });

    const result = await response.text();

    if (result.trim() === "success") {
      const elementToRemove = document.getElementById(id);
      if (elementToRemove) {
        elementToRemove.remove();
      }

      document.getElementById("addContent").innerHTML =
        "<h2 class='desc-header'>Bookmark deleted successfully</h2>";
    } else {
      alert("Failed to delete the bookmark. Please try again.");
    }
  } catch (error) {
    console.error("Error:", error);
  }
};

const btnOpenModal = document.querySelector(".btn-search");
const btnCloseModal = document.querySelector("#cancel-btn");
const modal = document.querySelector(".modal");
const overlay = document.querySelector(".overlay");

const openModal = function () {
  modal.classList.remove("hidden");
  overlay.classList.remove("hidden");
};

const closeModal = function () {
  modal.classList.add("hidden");
  overlay.classList.add("hidden");
};

btnOpenModal.addEventListener("click", openModal);

btnCloseModal.addEventListener("click", closeModal);

// -----------------------------------------------------------
const nextBtn = document.querySelector("#next-btn"); // Or whatever class your green button has
const urlInput = document.querySelector("#URL"); // The input from image_47657e.png

nextBtn.addEventListener("click", async () => {
  const url = urlInput.value.trim();

  if (!url) {
    alert("Please enter a URL");
    return;
  }

  nextBtn.innerText = `Processing...`;
  nextBtn.disabled = true;

  const formData = new FormData();
  formData.append("url", url);

  try {
    const response = await fetch("../php/add_bookmark.php", {
      method: "POST",
      body: formData,
    });

    const result = await response.json();

    if (result.status === "success") {
      closeModal();
      location.reload();
    } else {
      alert("Error: " + result.message);
    }
  } catch (error) {
    console.error("Fetch error:", error);
  } finally {
    nextBtn.innerText = `Error`;
    nextBtn.disabled = false;
  }
});
